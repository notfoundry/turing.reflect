unit
class LocalTFunction
    inherit TFunction in "%oot/reflect/TFunction.tu"
    import Opcodes in "%oot/reflect/Opcodes.tu",
        DefinedOpInspector in "util/DefinedOpInspector.tu",
        OpcodeHelper in "%oot/reflect/internal/util/OpcodeHelper.tu",
        Primitives in "%oot/reflect/Primitives.tu",
        ReflectionFactory in "util/ReflectionFactory.tu",
        MutableTypeClassifier in "%oot/reflect/internal/MutableTypeClassifier.tu",
        AnnotationManifest in "annotation/AnnotationManifest.tu",
        AnnotationFactory in "annotation/AnnotationFactory.tu",
        DefaultInvocationContext in "invocation/DefaultInvocationContext.tu",
        MutableRepeatedAnnotation in "annotation/MutableRepeatedAnnotation.tu"
    export construct
    
    var context: unchecked ^FunctionContext
    
    var annotations: unchecked ^AnnotationManifest := nil
    
    var returnType: unchecked ^TypeClassifier := nil
    
    proc construct(functionContext: unchecked ^FunctionContext)
        context := functionContext
    end construct
    
    body fcn getContext(): unchecked ^FunctionContext
        result context
    end getContext
    
    body fcn inspect(): unchecked ^OpInspector
        var resultInspector: ^DefinedOpInspector
        new resultInspector; resultInspector -> construct(context -> getStartAddress(), context -> getEndAddress());
        result resultInspector
    end inspect
    
    body fcn invokeArgs(returnAddr: addressint, instance: unchecked ^anyclass): unchecked ^InvocationContext
        var resultContext: ^DefaultInvocationContext
        new resultContext; resultContext -> construct(self, returnAddr, instance);
        result resultContext
    end invokeArgs
    
    body fcn getDeclaredAnnotationCount(): nat
        if (annotations = nil) then
            annotations := AnnotationFactory.getFunctionAnnotations(self)
        end if
        result annotations -> getAnnotationCount()
    end getDeclaredAnnotationCount
    
    body fcn getAnnotationCount(): nat
        result getDeclaredAnnotationCount()
    end getAnnotationCount
    
    body fcn getDeclaredAnnotationAt(position: nat): unchecked ^Annotation
        const count := getDeclaredAnnotationCount()
        if (position > count) then
            Error.Halt("Tried to access annotation #" + natstr(position)
                + ", but this construct only has " + natstr(count) + " annotations")
        elsif (position = 0) then
            Error.Halt("Function annotation access is one-indexed, annotation 0 cannot be accessed")
        end if
        
        result annotations -> getAnnotation(position)
    end getDeclaredAnnotationAt
    
    body fcn getAnnotationAt(position: nat): unchecked ^Annotation
        result getDeclaredAnnotationAt(position)
    end getAnnotationAt
    
    body fcn getDeclaredAnnotation(annotationType: cheat addressint): unchecked ^Annotation
        for i: 1..getDeclaredAnnotationCount()
            const lookup := annotations -> getAnnotation(i)
            if (lookup -> isInstance(annotationType)) then
                result lookup
            end if
        end for
        result nil
    end getDeclaredAnnotation
    
    body fcn getAnnotation(annotationType: cheat addressint): unchecked ^Annotation
        result getDeclaredAnnotation(annotationType)
    end getAnnotation
    
    body fcn getDeclaredAnnotations(annotationType: cheat addressint): unchecked ^RepeatedAnnotation
        var resultAnnotations: ^MutableRepeatedAnnotation; new resultAnnotations;
        for i: 1..getDeclaredAnnotationCount()
            const lookup := annotations -> getAnnotation(i)
            if (lookup -> isInstance(annotationType)) then
                resultAnnotations -> addAnnotation(lookup)
            end if
        end for
        result resultAnnotations
    end getDeclaredAnnotations
    
    body fcn getAnnotations(annotationType: cheat addressint): unchecked ^RepeatedAnnotation
        result getDeclaredAnnotations(annotationType)
    end getAnnotations
    
    body proc invoke(returnAddr: addressint, instance: unchecked ^anyclass)
        type __procedure: proc x()
        if (context -> isFunction()) then
            var tmp: array 1..* of nat := init(
                PROC, 0,
                PUSHADDR, 0,    %function pointer
                PUSHADDR, 0,    %return address
                CALL, 4,
                INCSP, 8,
                RETURN
            )
            tmp(4) := context -> getStartAddress()
            tmp(6) := returnAddr
            cheat(__procedure, addr(tmp))()
        else
            var tmp: array 1..* of nat := init(
                PROC, 0,
                PUSHADDR, 0,    %function pointer
                CALL, 0,
                INCSP, 4,
                RETURN
            )
            tmp(4) := context -> getStartAddress()
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