unit
class MutableAnnotation
    inherit Annotation in "%oot/reflect/annotation/Annotation.tu"
    import Opcodes in "%oot/reflect/Opcodes.tu",
        OpcodeHelper in "%oot/reflect/internal/util/OpcodeHelper.tu"
    export construct
    
    var annotationAddress: addressint

    var elements: flexible array 1..0 of addressint
    
    proc construct(__annotationAddress, callsite: addressint)
        annotationAddress := __annotationAddress
        
        var op := callsite
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
        
        /* We can safely skip ahead by 2 or 3 ops here to avoid hitting the actual annotation being pushed to the stack */
        case (Opcodes.TYPE @ (op)) of
            label Opcodes.PUSHADDR1:
                op += Opcodes.OP_SIZE * (Opcodes.argCount(Opcodes.PUSHADDR1) + 1)
            label Opcodes.PUSHADDR:
                op += Opcodes.OP_SIZE * (Opcodes.argCount(Opcodes.PUSHADDR) + 1)
        end case
        
        loop
            exit when Opcodes.TYPE @ (op) = Opcodes.CALL
            if (OpcodeHelper.isStackPushingOp(Opcodes.TYPE @ (op))) then
                new elements, upper(elements) + 1
                elements(upper(elements)) := OpcodeHelper.wrapValuePushedToStack(op)
            end if
            op += Opcodes.OP_SIZE
        end loop
        
    end construct
    
    body fcn getElementCount(): nat
        result upper(elements)
    end getElementCount
    
    body fcn getElement(position: nat): addressint
        if (position > upper(elements)) then
            Error.Halt("attempted to access annotation element at position " + natstr(position)
                + ", but only " + intstr(upper(elements)) + " element exist")
        else
            result elements(position)
        end if
    end getElement
    
    body fcn isInstance(annotationType: cheat addressint): boolean
        result annotationType = annotationAddress
    end isInstance
    
end MutableAnnotation