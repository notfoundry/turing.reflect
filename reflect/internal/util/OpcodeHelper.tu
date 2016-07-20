unit
module OpcodeHelper
    import Opcodes in "%oot/reflect/Opcodes.tu", Primitives in "%oot/reflect/Primitives.tu"
    export isDereferencingOp, returnTypeFromMergeOp
    
    fcn isDereferencingOp(op: nat): boolean
        if (op >= Opcodes.ASNADDRINV & op <= Opcodes.ASNSTRINV) then
            /* within the range of assignment ops */
            result op mod 2 = 0
        else
            result false
        end if
    end isDereferencingOp
    
    fcn returnTypeFromMergeOp(op: nat): Primitives.TYPE
        case (op) of
            label Opcodes.ASNADDRINV: result Primitives.UNCHECKED_PTR
            label Opcodes.ASNINTINV: result Primitives.INT
            label Opcodes.ASNINT1INV: result Primitives.INT1
            label Opcodes.ASNINT2INV: result Primitives.INT2
            label Opcodes.ASNINT4INV: result Primitives.INT4
            label Opcodes.ASNNATINV: result Primitives.NAT
            label Opcodes.ASNNAT1INV: result Primitives.NAT1
            label Opcodes.ASNNAT2INV: result Primitives.NAT2
            label Opcodes.ASNNAT4INV: result Primitives.NAT4
            label Opcodes.ASNNONSCALARINV: result Primitives.NONSCALAR
            label Opcodes.ASNPTRINV: result Primitives.CHECKED_PTR
            label Opcodes.ASNREALINV: result Primitives.REAL
            label Opcodes.ASNREAL4INV: result Primitives.REAL4
            label Opcodes.ASNREAL8INV: result Primitives.REAL8
            label Opcodes.ASNSTRINV: result Primitives.STRING
        end case
    end returnTypeFromMergeOp
end OpcodeHelper