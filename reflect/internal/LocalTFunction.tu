unit
class LocalTFunction
    inherit TFunction in "%oot/reflect/TFunction.tu"
    import Opcodes in "%oot/reflect/Opcodes.tu",
        DefinedOpInspector in "util/DefinedOpInspector.tu",
        OpcodeHelper in "%oot/reflect/internal/util/OpcodeHelper.tu",
        Primitives in "%oot/reflect/Primitives.tu",
        ReflectionFactory in "util/ReflectionFactory.tu",
        MutableTypeClassifier in "%oot/reflect/internal/MutableTypeClassifier.tu",
        AnnotatedFunctionElement in "annotation/AnnotatedFunctionElement.tu",
        MutableInvocationContext in "invocation/MutableInvocationContext.tu"
    export construct
    
    var context: unchecked ^FunctionContext
    
    var annotations: unchecked ^AnnotatedElement := nil
    
    var returnType: unchecked ^TypeClassifier := nil
    
    proc construct(functionContext: unchecked ^FunctionContext)
        context := functionContext
    end construct
    
    body fcn fetch(): addressint
        result context -> getStartAddress()
    end fetch
    
    body fcn getContext(): unchecked ^FunctionContext
        result context
    end getContext
    
    body fcn inspect(): unchecked ^OpInspector
        var resultInspector: ^DefinedOpInspector
        new resultInspector; resultInspector -> construct(context -> getStartAddress(), context -> getEndAddress());
        result resultInspector
    end inspect
    
    body fcn invokeArgs(returnAddr, instanceAddr: addressint): unchecked ^InvocationContext
        var resultContext: ^MutableInvocationContext
        new resultContext; resultContext -> construct(context, returnAddr, instanceAddr);
        result resultContext
    end invokeArgs
    
    body fcn getAnnotations(): unchecked ^AnnotatedElement
        if (annotations = nil) then
            var resultElement: ^AnnotatedFunctionElement
            new resultElement; resultElement -> construct(getContext());
            annotations := resultElement
        end if
        result annotations
    end getAnnotations
    
    body proc invoke(returnAddr: addressint, instance: unchecked ^anyclass)
        type __procedure: proc x()

        if (context -> isFunction()) then
            var tmp: array 1..* of nat := init(
                PROC, 0,
                PUSHADDR1, 0, 0,
                PUSHADDR, 0,
                CALL, 4,
                INCSP, 8,
                RETURN
            )
            tmp(5) := context -> getStartAddress()
            tmp(7) := returnAddr
            cheat(__procedure, addr(tmp))()
        else
            var tmp: array 1..* of nat := init(
                PROC, 0,
                PUSHADDR1, 0, 0,
                CALL, 0,
                INCSP, 4,
                RETURN
            )
            tmp(5) := context -> getStartAddress()
            cheat(__procedure, addr(tmp))()
        end if
    end invoke
    
    body fcn getReturnType(): unchecked ^TypeClassifier
        if (returnType = nil) then
            var resultVal: ^MutableTypeClassifier; new resultVal;
            var finalType: Primitives.TYPE;
            var finalSize: nat;
            
            var op := context -> getEndAddress()
            loop
                if (op = context -> getStartAddress()) then
                    finalType := Primitives.VOID
                    finalSize := Primitives.sizeOf(Primitives.VOID)
                    exit
                elsif (OpcodeHelper.isDereferencingOp(Opcodes.TYPE @ (op))) then
                    if (Opcodes.TYPE @ (op-Opcodes.OP_SIZE) ~= ASNNONSCALARINV) then
                        finalType := OpcodeHelper.returnTypeFromMergeOp(Opcodes.TYPE @ (op))
                        const sizeLookup := Primitives.sizeOf(finalType)
                        
                        if (sizeLookup = Primitives.sizeOf(Primitives.NONSCALAR)) then finalSize := Opcodes.TYPE @ (op+Opcodes.OP_SIZE)
                        elsif (sizeLookup = Primitives.sizeOf(Primitives.STRING)) then finalSize := Opcodes.TYPE @ (op-Opcodes.OP_SIZE)
                        else finalSize := sizeLookup
                        end if
                        exit
                    end if
                end if
                op -= Opcodes.OP_SIZE
            end loop
            resultVal -> construct(finalType, finalSize)
            returnType := resultVal
        end if
        result returnType
    end getReturnType
end LocalTFunction