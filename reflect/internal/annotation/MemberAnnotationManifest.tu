unit
class MemberAnnotationManifest
    inherit AnnotationManifest in "AnnotationManifest.tu"
    import FunctionContext in "%oot/reflect/context/FunctionContext.tu",
        Annotation in "%oot/reflect/annotation/Annotation.tu",
        MutableAnnotation in "MutableAnnotation.tu",
        OpInspector in "%oot/reflect/util/OpInspector.tu",
        Opcodes in "%oot/reflect/Opcodes.tu",
        Annotations in "%oot/reflect/annotations"
    export construct
    
    const NONEXISTENT_FUNCTION := 0
    
    var annotations: flexible array 1..0 of unchecked ^Annotation
    
    fcn getCalledFunction(callOpAddress: addressint): addressint
        var op := callOpAddress
        loop
            case (Opcodes.TYPE @ (op)) of
                label SETLINENO:
                    op += Opcodes.OP_SIZE * (Opcodes.argCount(Opcodes.SETLINENO) + 1)
                    exit
                label SETFILENO:
                    op += Opcodes.OP_SIZE * (Opcodes.argCount(Opcodes.SETFILENO) + 1)
                    exit
                label INCLINENO:
                    op += Opcodes.OP_SIZE
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
        if (op = NONEXISTENT_FUNCTION) then result false
        end if
        loop
            case (Opcodes.TYPE @ (op)) of
                label Opcodes.CALL:
                    op := getCalledFunction(op)
                    if (op = #annotation) then result true
                    else 
                        result isAnnotationProcedure(op)
                    end if
                label Opcodes.PROC, Opcodes.RETURN:
                    result false
                label:
                    op -= Opcodes.OP_SIZE
            end case
        end loop
    end isAnnotationProcedure
    
    proc construct(constructAddress: addressint)
        var op := constructAddress - Opcodes.OP_SIZE
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
                label Opcodes.PROC, Opcodes.RETURN, Opcodes.LOCATECLASS:
                    exit
                label:
            end case
            op -= Opcodes.OP_SIZE
        end loop
    end construct
    
    body fcn getAnnotationCount(): nat
        result upper(annotations)
    end getAnnotationCount
    
    body fcn getAnnotation(position: nat): unchecked ^Annotation
        result annotations(position)
    end getAnnotation
end MemberAnnotationManifest