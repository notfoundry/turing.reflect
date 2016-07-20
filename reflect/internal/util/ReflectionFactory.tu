unit
module ReflectionFactory
    import Opcodes in "%oot/reflect/Opcodes.tu",
            FunctionContext in "%oot/reflect/context/FunctionContext.tu",
            ClassContext in "%oot/reflect/context/ClassContext.tu"
    export makeFunctionContext, makeClassContext
    
    const OP_SIZE := 4
    
    fcn isFunctionEnd(address: addressint): boolean
        var op := nat @ (address)
        case (op) of
        label Opcodes.RETURN:
            if (nat @ (address-OP_SIZE*2) = Opcodes.SETLINENO
                    | nat @ (address-OP_SIZE*3) = Opcodes.SETFILENO
                    | nat @ (address-OP_SIZE) = Opcodes.INCLINENO
                    | nat @ (address-OP_SIZE) = Opcodes.DEALLOCFLEXARRAY) then
                result true
            end if
        label Opcodes.ADDSET:
            if (nat @ (address-OP_SIZE) = Opcodes.ABORT) then
                result true
            end if
        label:
        end case
        result false
    end isFunctionEnd
    
    fcn isHandlerFunctionEnd(address: addressint): boolean
        if (nat @ (address) = Opcodes.RETURN
                & nat @ (address-OP_SIZE) = Opcodes.UNLINKHANDLER) then
            result true
        end if
        result false
    end isHandlerFunctionEnd
    
    fcn isFunction(address: addressint, isClass: boolean): boolean
        var returnDef := 0
        if (isClass) then
            returnDef := 4
        end if
        if (nat @ (address) = Opcodes.LOCATEPARM
            & nat @ (address+OP_SIZE) = returnDef
            & nat @ (address+OP_SIZE*2) = Opcodes.FETCHADDR) then
            result true
        end if
        result false
    end isFunction
    
    fcn isClassEnd(address: addressint): boolean
        var op := nat @ (address)
        case (op) of
        label Opcodes.RETURN:
            if (nat @ (address-OP_SIZE) = Opcodes.ASNADDR) then result true
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
        
        if (nat @ (procedureAddr + OP_SIZE*6) = Opcodes.BEGINHANDLER) then
            hasHandler := true
        end if
        loop
            var op := nat @ (curr)
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
            if (op = Opcodes.INCLINENO) then
                lineCount += 1
            end if
            opCount += 1
            curr += OP_SIZE
        end loop
        
        var context: ^FunctionContext
        new context; context -> construct(procedureAddr, endAddress, isFunc, internal, lineCount, nat @ (procedureAddr+OP_SIZE), opCount);
        result context
    end makeFunctionContext
    
    fcn makeClassContext(classAddr: addressint): unchecked ^ClassContext
        var endAddress: addressint
        var foundEndAddress: boolean := false
        
        var curr := classAddr
        var lineCount: nat := 1
        var opCount: nat := 0
        loop
            var op := nat @ (curr)
            exit when foundEndAddress
            if (~foundEndAddress & isClassEnd(curr)) then
                endAddress := curr
                foundEndAddress := true
            end if
            if (op = Opcodes.INCLINENO) then
                lineCount += 1
            end if
            opCount += 1
            curr += OP_SIZE
        end loop
        
        var context: ^ClassContext
        new context; context -> construct(classAddr, endAddress, lineCount, opCount);
        result context
    end makeClassContext
end ReflectionFactory