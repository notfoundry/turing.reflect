unit
module ReflectionFactory
    import Opcodes in "%oot/reflect/Opcodes.tu",
            FunctionContext in "%oot/reflect/context/FunctionContext.tu",
            DeclaredFunctionContext in "%oot/reflect/internal/context/DeclaredFunctionContext.tu",
            ClassContext in "%oot/reflect/context/ClassContext.tu",
            DeclaredClassContext in "%oot/reflect/internal/context/DeclaredClassContext.tu"
    export makeFunctionContext, makeClassContext
    
    fcn isFunctionEnd(address: addressint): boolean
        var op: Opcodes.TYPE := Opcodes.TYPE @ (address)
        case (op) of
        label RETURN:
            if (Opcodes.TYPE @ (address-Opcodes.OP_SIZE*2) = SETLINENO
                    | Opcodes.TYPE @ (address-Opcodes.OP_SIZE*3) = SETFILENO
                    | Opcodes.TYPE @ (address-Opcodes.OP_SIZE) = INCLINENO
                    | Opcodes.TYPE @ (address-Opcodes.OP_SIZE) = DEALLOCFLEXARRAY) then
                result true
            end if
        label ADDSET:
            if (Opcodes.TYPE @ (address-Opcodes.OP_SIZE) = ABORT) then
                result true
            end if
        label:
        end case
        result false
    end isFunctionEnd
    
    fcn isHandlerFunctionEnd(address: addressint): boolean
        result Opcodes.TYPE @ (address) = RETURN
                & Opcodes.TYPE @ (address-Opcodes.OP_SIZE) = UNLINKHANDLER
    end isHandlerFunctionEnd
    
    fcn isFunction(address: addressint, isClass: boolean): boolean
        var returnDef := 0
        if (isClass) then
            returnDef := Opcodes.OP_SIZE
        end if
        if (Opcodes.TYPE @ (address) = LOCATEPARM
            & Opcodes.TYPE @ (address+Opcodes.OP_SIZE) = returnDef
            & Opcodes.TYPE @ (address+Opcodes.OP_SIZE*2) = FETCHADDR) then
            result true
        end if
        result false
    end isFunction
    
    fcn isClassEnd(address: addressint): boolean
        var op := Opcodes.TYPE @ (address)
        case (op) of
        label RETURN:
            if (Opcodes.TYPE @ (address-Opcodes.OP_SIZE) = ASNADDR) then result true
            end if
        label:
        end case
        result false
    end isClassEnd
    
    fcn makeFunctionContext(procedureAddr: cheat addressint, internal: boolean): unchecked ^FunctionContext
        var endAddress: addressint
        var isFunc, hasHandler, foundEndAddress, foundFunc: boolean := false
        
        var curr := procedureAddr
        var lineCount: nat := 1
        var opCount: nat := 0
        
        if (Opcodes.TYPE @ (procedureAddr + Opcodes.OP_SIZE*6) = BEGINHANDLER) then
            hasHandler := true
        end if
        loop
            var op: Opcodes.TYPE := Opcodes.TYPE @ (curr)
            exit when foundEndAddress
            if ((hasHandler
                    & ~foundEndAddress
                    & isHandlerFunctionEnd(curr))
                | (~hasHandler
                    & ~foundEndAddress
                    & isFunctionEnd(curr))) then
                    
                endAddress := curr
                foundEndAddress := true
            end if
            if (~foundFunc & isFunction(curr, internal)) then
                isFunc := true
                foundFunc := true
            end if
            if (op = INCLINENO) then
                lineCount += 1
            end if
            opCount += 1
            curr += Opcodes.OP_SIZE
        end loop
        
        var context: ^DeclaredFunctionContext
        new context; context -> construct(procedureAddr, endAddress, isFunc, internal, lineCount, Opcodes.TYPE @ (procedureAddr+Opcodes.OP_SIZE), opCount);
        result context
    end makeFunctionContext
    
    fcn makeClassContext(classAddr: addressint): unchecked ^ClassContext
        var endAddress: addressint
        var foundEndAddress: boolean := false
        
        var curr := classAddr
        var lineCount: nat := 1
        var opCount: nat := 0
        loop
            var op := Opcodes.TYPE @ (curr)
            exit when foundEndAddress
            if (~foundEndAddress & isClassEnd(curr)) then
                endAddress := curr
                foundEndAddress := true
            end if
            if (op = INCLINENO) then
                lineCount += 1
            end if
            opCount += 1
            curr += Opcodes.OP_SIZE
        end loop
        
        var context: ^DeclaredClassContext
        new context; context -> construct(classAddr, endAddress, lineCount, opCount);
        result context
    end makeClassContext
end ReflectionFactory