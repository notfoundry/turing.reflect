unit
class ClassTFunction
    inherit LocalTFunction in "LocalTFunction.tu"
    
    body proc invoke(returnAddr: addressint, instance: unchecked ^anyclass)
        type __procedure: proc x()
        if (getContext() -> isFunction()) then
            var ops: array 1..* of Opcodes.TYPE := init(
                PROC, 0,
                PUSHADDR, 0,    %function pointer
                PUSHADDR, 0,    %return address
                PUSHADDR, 0,    %instance pointer
                CALL, 8,
                INCSP, 16,
                RETURN
            )
            ops(4) := getContext() -> getStartAddress()
            ops(6) := returnAddr
            ops(8) := #instance
            cheat(__procedure, addr(ops))()
        else
            var ops: array 1..* of Opcodes.TYPE := init (
                PROC, 0,
                PUSHADDR, 0,    %function pointer
                PUSHADDR, 0,    %instance pointer
                CALL, 4,
                INCSP, 12,
                RETURN
            )
            ops(4) := getContext() -> getStartAddress()
            ops(6) := #instance
            cheat(__procedure, addr(ops))()
        end if
    end invoke
    
end ClassTFunction