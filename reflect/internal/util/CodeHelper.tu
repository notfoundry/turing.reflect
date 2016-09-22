unit
module CodeHelper
    import Opcodes in "%oot/reflect/Opcodes.tu"
    export findClassEnd, findProcedureEnd, isFunction
    
    fcn findProcedureEnd(start: addressint): addressint
        var curr := start
        loop
            var op := Opcodes.TYPE @ (curr)
            case (op) of
            label SETLINENO:
                if (Opcodes.TYPE @ (curr+Opcodes.OP_SIZE*2) = RETURN) then result curr+Opcodes.OP_SIZE*2
                end if
            label SETFILENO:
                if (Opcodes.TYPE @ (curr+Opcodes.OP_SIZE*3) = RETURN) then result curr+Opcodes.OP_SIZE*3
                end if
            label INCLINENO:
                if (Opcodes.TYPE @ (curr+Opcodes.OP_SIZE) = RETURN) then result curr+Opcodes.OP_SIZE
                end if
            label DEALLOCFLEXARRAY:
                if (Opcodes.TYPE @ (curr+Opcodes.OP_SIZE) = RETURN) then result curr+Opcodes.OP_SIZE
                end if
            label ABORT:
                if (Opcodes.TYPE @ (curr+Opcodes.OP_SIZE) = ADDSET) then result curr+Opcodes.OP_SIZE
                end if
            label:
            end case
            curr += Opcodes.OP_SIZE
        end loop
    end findProcedureEnd
    
    fcn isFunction(start, last: addressint, isClass: boolean): boolean
        var isFunction: boolean := false
        for i: start..last by Opcodes.OP_SIZE
            if (Opcodes.TYPE @ (i) = LOCATEPARM
                    & Opcodes.TYPE @ (i+Opcodes.OP_SIZE) = 0
                    & Opcodes.TYPE @ (i+Opcodes.OP_SIZE*2) = FETCHADDR) then
                isFunction := true
                exit
            end if
        end for
        result isFunction
    end isFunction
    
    fcn findClassEnd(start: addressint): addressint
        var curr := start
        loop
            var op := Opcodes.TYPE @ (curr)
            case (op) of
            label ASNADDR:
                if (Opcodes.TYPE @ (curr+Opcodes.OP_SIZE) = RETURN) then result curr+Opcodes.OP_SIZE
                end if
            label:
            end case
            curr += Opcodes.OP_SIZE
        end loop
    end findClassEnd
end CodeHelper