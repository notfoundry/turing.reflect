unit
class AnnotatedFunctionElement
    inherit AnnotatedElement in "%oot/reflect/annotation/AnnotatedElement.tu"
    import FunctionContext in "%oot/reflect/context/FunctionContext.tu",
        MutableAnnotation in "MutableAnnotation.tu",
        OpInspector in "%oot/reflect/util/OpInspector.tu",
        Opcodes in "%oot/reflect/Opcodes.tu",
        Annotations in "%oot/reflect/annotations"
    export construct

    var annotations: flexible array 1..0 of unchecked ^MutableAnnotation
    
    fcn getCalledFunction(callOpAddress: addressint): addressint
        var op := callOpAddress
        loop
            case (Opcodes.TYPE @ (op)) of
                label Opcodes.SETLINENO:
                    op += Opcodes.OP_SIZE * (Opcodes.argCount(Opcodes.SETLINENO) + 1)
                    exit
                label Opcodes.SETFILENO:
                    op += Opcodes.OP_SIZE * (Opcodes.argCount(Opcodes.SETFILENO) + 1)
                    exit
                label:
                    op -= Opcodes.OP_SIZE
            end case
        end loop
        case (Opcodes.TYPE @ (op)) of
            label Opcodes.PUSHADDR1:
                result Opcodes.TYPE @ (op + Opcodes.OP_SIZE * 2)
            label Opcodes.PUSHADDR:
                result Opcodes.TYPE @ (op + Opcodes.OP_SIZE)
        end case
    end getCalledFunction
    
    fcn isAnnotationProcedure(address: addressint): boolean
        var op := address - Opcodes.OP_SIZE
        loop
            case (Opcodes.TYPE @ (op)) of
                label Opcodes.CALL:
                    op := getCalledFunction(op)
                    if (op = #annotation) then result true
                    else result isAnnotationProcedure(op)
                    end if
                label Opcodes.PROC, Opcodes.RETURN:
                    result false
                label:
                    op -= Opcodes.OP_SIZE
            end case
        end loop
    end isAnnotationProcedure
    
    proc construct(context: unchecked ^FunctionContext)
        var op := context -> getStartAddress() - Opcodes.OP_SIZE
        loop
            case (Opcodes.TYPE @ (op)) of
                label Opcodes.CALL:
                    const calledFunction := getCalledFunction(op)
                    if (isAnnotationProcedure(calledFunction)) then
                        var annotationLookup: ^MutableAnnotation
                        new annotationLookup; annotationLookup -> construct(calledFunction, op);
                        
                        new annotations, upper(annotations) + 1
                        annotations(upper(annotations)) := annotationLookup
                    else
                        exit
                    end if
                label Opcodes.PROC, Opcodes.RETURN:
                    exit
                label:
            end case
            op -= Opcodes.OP_SIZE
        end loop
    end construct
    
    body fcn getAnnotationCount(): nat
        result upper(annotations)
    end getAnnotationCount
    
    body fcn getAnnotationAt(position: nat): unchecked ^Annotation
        if (position > upper(annotations)) then
            Error.Halt("attempted to access annotation at position " + natstr(position)
                + ", but only " + intstr(upper(annotations)) + " annotations exist")
        else
            result annotations(position)
        end if
    end getAnnotationAt
    
    body fcn getAnnotation(annotationType: cheat addressint): unchecked ^Annotation
        for i: lower(annotations)..upper(annotations)
            if (annotations(i) -> isInstance(annotationType)) then
                result annotations(i)
            end if
        end for
        result nil
    end getAnnotation
    
end AnnotatedFunctionElement