unit
module OpcodeHelper
    import Opcodes in "%oot/reflect/Opcodes.tu",
        Primitives in "%oot/reflect/Primitives.tu"
    export isStackPushingOp, isDereferencingOp, returnTypeFromMergeOp, returnTypeFromStackPushingOp, wrapValuePushedToStack
    
    var ZERO := 0
    var ONE := 1
    
    fcn isStackPushingOp(op: Opcodes.TYPE): boolean
        result op >= PUSHADDR & op <= PUSHVAL1
    end isStackPushingOp
    
    fcn isDereferencingOp(op: Opcodes.TYPE): boolean
        if (op >= ASNADDRINV & op <= ASNSTRINV) then
            /* within the range of assignment ops */
            result op mod 2 = 0
        else
            result false
        end if
    end isDereferencingOp
    
    fcn returnTypeFromMergeOp(op: Opcodes.TYPE): Primitives.TYPE
        case (op) of
            label ASNADDRINV: result Primitives.UNCHECKED_PTR
            label ASNINTINV: result Primitives.INT
            label ASNINT1INV: result Primitives.INT1
            label ASNINT2INV: result Primitives.INT2
            label ASNINT4INV: result Primitives.INT4
            label ASNNATINV: result Primitives.NAT
            label ASNNAT1INV: result Primitives.NAT1
            label ASNNAT2INV: result Primitives.NAT2
            label ASNNAT4INV: result Primitives.NAT4
            label ASNNONSCALARINV: result Primitives.NONSCALAR
            label ASNPTRINV: result Primitives.CHECKED_PTR
            label ASNREALINV: result Primitives.REAL
            label ASNREAL4INV: result Primitives.REAL4
            label ASNREAL8INV: result Primitives.REAL8
            label ASNSTRINV: result Primitives.STRING
        end case
    end returnTypeFromMergeOp
    
    fcn returnTypeFromStackPushingOp(op: Opcodes.TYPE): Primitives.TYPE
        case (op) of
            label PUSHADDR: result Primitives.UNCHECKED_PTR
            label PUSHADDR1: result Primitives.UNCHECKED_PTR
            label PUSHINT: result Primitives.INT
            label PUSHINT1: result Primitives.INT1
            label PUSHINT2: result Primitives.INT2
            label PUSHREAL: result Primitives.REAL
            label PUSHVAL0: result Primitives.INT
            label PUSHVAL1: result Primitives.INT
        end case
    end returnTypeFromStackPushingOp
    
    fcn wrapValuePushedToStack(opAddress: addressint): addressint
        case (Opcodes.TYPE @ (opAddress)) of
            label PUSHADDR: result addressint @ (opAddress + Opcodes.OP_SIZE)
            label PUSHADDR1: result addressint @ (opAddress + Opcodes.OP_SIZE * 2)
            label PUSHINT: result opAddress + Opcodes.OP_SIZE
            label PUSHINT1: result opAddress + Opcodes.OP_SIZE
            label PUSHINT2: result opAddress + Opcodes.OP_SIZE
            label PUSHREAL: result opAddress + Opcodes.OP_SIZE
            label PUSHVAL0: result addr(ZERO)
            label PUSHVAL1: result addr(ONE)
            label: Error.Halt(natstr(opAddress) + " does not point to a stack-pushing opcode")
        end case
    end wrapValuePushedToStack
end OpcodeHelper