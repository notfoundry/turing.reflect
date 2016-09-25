unit
class ClassTFunction
    inherit LocalTFunction in "LocalTFunction.tu"
    
    body proc invoke(returnAddr: addressint, instance: unchecked ^anyclass)
        type __procedure: proc x()
        if (getContext() -> isFunction()) then
            var ops: array 1..* of Opcodes.TYPE := init (
                PROC, 4,
                PUSHADDR, 0, %returnAddr
                PUSHADDR, 0, %instance
                FETCHADDR,
                RESOLVEPTR,
                PUSHCOPY,
                RESOLVEDEF,
                ASNNATINV,
                LOCATETEMP, 4, 0,
                LOCATEARG, 8,
                FETCHADDR,
                CALL, 8,
                INCSP, 16,
                LOCATETEMP, 4, 0,
                FETCHINT4,
                ASNINT,
                RETURN
            )
            ops(4) := returnAddr
            ops(6) := #instance
            cheat(__procedure, addr(ops))()
        else
            var ops: array 1..* of Opcodes.TYPE := init (
                PROC, 0,
                PUSHADDR, 0,    %instance pointer
                PUSHADDR, 0,    %function address
                CALL, 0,
                INCSP, 12,
                RETURN
            )
            var instref := instance
            ops(4) := addr(instref)
            ops(6) := getContext() -> getStartAddress()
            cheat(__procedure, addr(ops))()
        end if
    end invoke
    
end ClassTFunction