unit
module *Memory
    export Copy, CopyRet, Alloc, Free
    type __procedure: proc x()
    
    proc Copy(dst, src: addressint, bytes: nat)
        /*
        Opcodes.PROC, 0,
        Opcodes.PUSHADDR, 0,         source
        Opcodes.PUSHADDR, 0,         destination
        Opcodes.ASNNONSCALARINV, 0,  bytes
        Opcodes.RETURN
        */
        var tmp: array 1..9 of nat := init(
            186, 0,
            187, 0,
            187, 0,
            36, 0,
            205
        )
        tmp(4) := src
        tmp(6) := dst
        tmp(8) := bytes
        cheat(__procedure, addr(tmp))()
    end Copy
    
    fcn CopyRet(dst, src: addressint, bytes: nat): addressint
        Copy(dst, src, bytes)
        result dst
    end CopyRet
    
    fcn Alloc(bytes: nat): addressint
        var ptr: addressint
        /*
        Opcodes.PROC, 0,
        Opcodes.DECSP, 4,
        Opcodes.PUSHADDR, 0,    pointer to returned address
        Opcodes.PUSHINT, 0,     bytes
        Opcodes.ALLOCGLOB,
        Opcodes.RETURN
        */
        var ops: array 1..10 of nat4 := init(
            186, 0,
            71, 4,
            187, 0,
            190, 0,
            11,
            205
        )
        ops(6) := addr(ptr)
        ops(8) := bytes
        cheat(__procedure, addr(ops))()
        result ptr
    end Alloc
    
    proc Free(address: addressint)
        var __address := address
        /*
        Opcodes.PROC, 0,
        Opcodes.PUSHADDR, 0,    address
        Opcodes.FREEU,
        Opcodes.RETURN
        */
        var ops: array 1..6 of nat4 := init(
            186, 0,
            187, 0,
            110,
            205
        )
        ops(4) := addr(__address)
        cheat(__procedure, addr(ops))()
    end Free
end Memory