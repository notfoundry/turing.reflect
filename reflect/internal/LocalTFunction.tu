unit
class LocalTFunction
    inherit TFunction in "%oot/reflect/TFunction.tu"
    import Opcodes in "%oot/reflect/Opcodes.tu",
        OpcodeHelper in "%oot/reflect/internal/util/OpcodeHelper.tu",
        Primitives in "%oot/reflect/Primitives.tu",
        ReflectionFactory in "util/ReflectionFactory.tu",
        MutableReturnValue in "%oot/reflect/invocation/MutableReturnValue.tu"
    export construct
    var context: unchecked ^FunctionContext
    
    proc construct(procedureContext: unchecked ^FunctionContext)
        context := procedureContext
    end construct
    
    body fcn fetch(): addressint
        result context -> getStartAddress()
    end fetch
    
    body fcn getContext(): unchecked ^FunctionContext
        result context
    end getContext
    
    body fcn inspect(): unchecked ^OpInspector
        var resultInspector: ^OpInspector
        new resultInspector; resultInspector -> construct(context -> getStartAddress(), context -> getEndAddress());
        result resultInspector
    end inspect
    
    body fcn invokeArgs(returnAddr, instanceAddr: addressint): unchecked ^InvocationContext
        var resultContext: ^InvocationContext
        new resultContext; resultContext -> construct(context, returnAddr, instanceAddr);
        result resultContext
    end invokeArgs
    
    body proc invoke(returnAddr: addressint)
        type __procedure: proc x()
        
        var isFunction: boolean := false
        var it := inspect()
        loop
            exit when ~it -> hasNext()
            var op := it -> next()
            if (^op = Opcodes.LOCATEPARM
                & nat @ (#op+4) = 0
                & nat @ (#op+8) = Opcodes.FETCHADDR) then
                isFunction := true
                exit
            end if
        end loop
        
        if (isFunction) then
            var tmp: array 1..* of nat := init(
                Opcodes.PROC, 0,
                Opcodes.PUSHADDR1, 0, 0,
                Opcodes.PUSHADDR, 0,
                Opcodes.CALL, 4,
                Opcodes.INCSP, 8,
                Opcodes.RETURN
            )
            tmp(5) := context -> getStartAddress()
            tmp(7) := returnAddr
            cheat(__procedure, addr(tmp))()
        else
            var tmp: array 1..* of nat := init(
                Opcodes.PROC, 0,
                Opcodes.PUSHADDR1, 0, 0,
                Opcodes.CALL, 0,
                Opcodes.INCSP, 4,
                Opcodes.RETURN
            )
            tmp(5) := context -> getStartAddress()
            cheat(__procedure, addr(tmp))()
        end if
    end invoke
    
    body fcn getReturnType(): unchecked ^ReturnValue
        var resultVal: ^MutableReturnValue; new resultVal;
        var finalType: Primitives.TYPE; var finalSize: nat;
        
        var op := context -> getEndAddress()
        loop
            if (op = context -> getStartAddress()) then
                finalType := Primitives.VOID
                finalSize := Primitives.sizeOf(Primitives.VOID)
                exit
            elsif (OpcodeHelper.isDereferencingOp(nat @ (op))) then
                if (nat @ (op-Opcodes.OP_SIZE) ~= Opcodes.ASNNONSCALARINV) then
                    finalType := OpcodeHelper.returnTypeFromMergeOp(nat @ (op))
                    const sizeLookup := Primitives.sizeOf(finalType)
                    
                    if (sizeLookup = Primitives.sizeOf(Primitives.NONSCALAR)) then finalSize := nat @ (op+4)
                    elsif (sizeLookup = Primitives.sizeOf(Primitives.STRING)) then finalSize := nat @ (op-4)
                    else finalSize := sizeLookup
                    end if
                    exit
                end if
            end if
            op -= Opcodes.OP_SIZE
        end loop
        resultVal -> construct(finalType, finalSize)
        result resultVal
    end getReturnType
end LocalTFunction