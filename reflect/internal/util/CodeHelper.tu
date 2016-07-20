unit
module CodeHelper
    import Opcodes in "%oot/reflect/Opcodes.tu"
    export findClassEnd, findProcedureEnd, isFunction
    
    fcn findProcedureEnd(start: addressint): addressint
        var curr := start
        loop
            var op := nat @ (curr)
            case (op) of
            label Opcodes.SETLINENO:
                if (nat @ (curr+8) = Opcodes.RETURN) then result curr+8
                end if
            label Opcodes.SETFILENO:
                if (nat @ (curr+12) = Opcodes.RETURN) then result curr+12
                end if
            label Opcodes.INCLINENO:
                if (nat @ (curr+4) = Opcodes.RETURN) then result curr+4
                end if
            label Opcodes.DEALLOCFLEXARRAY:
                if (nat @ (curr+4) = Opcodes.RETURN) then result curr+4
                end if
            label Opcodes.ABORT:
                if (nat @ (curr+4) = Opcodes.ADDSET) then result curr+4
                end if
            label:
            end case
            curr += sizeof(nat)
        end loop
    end findProcedureEnd
    
    fcn isFunction(start, last: addressint, isClass: boolean): boolean
        var isFunction: boolean := false
        for i: start..last by 4
            if (nat @ (i) = Opcodes.LOCATEPARM
                    & nat @ (i+4) = 0
                    & nat @ (i+8) = Opcodes.FETCHADDR) then
                isFunction := true
                exit
            end if
        end for
        result isFunction
    end isFunction
    
    fcn findClassEnd(start: addressint): addressint
        var curr := start
        loop
            var op := nat @ (curr)
            case (op) of
            label Opcodes.ASNADDR:
                if (nat @ (curr+4) = Opcodes.RETURN) then result curr+4
                end if
            label:
            end case
            curr += sizeof(nat)
        end loop
    end findClassEnd
end CodeHelper