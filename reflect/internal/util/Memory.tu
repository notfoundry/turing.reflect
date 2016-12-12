unit
module *Memory
    import Opcodes in "%oot/reflect/Opcodes.tu"
    export Copy, CopyRet, Alloc, Free
    type __procedure: proc x()
    
    proc Copy(dst, src: addressint, bytes: nat)
        var ops: array 1..* of Opcodes.TYPE := init(
            PROC, 0,
            PUSHADDR, 0,         %source
            PUSHADDR, 0,         %destination
            ASNNONSCALARINV, 0,  %bytes
            RETURN
        )
        ops(4) := src
        ops(6) := dst
        ops(8) := bytes
        cheat(__procedure, addr(ops))()
    end Copy
    
    fcn CopyRet(dst, src: addressint, bytes: nat): addressint
        Copy(dst, src, bytes)
        result dst
    end CopyRet
    
    fcn Alloc(bytes: nat): addressint
        var ptr: addressint
        var ops: array 1..* of Opcodes.TYPE := init(
            PROC, 0,
            DECSP, 4,
            PUSHADDR, 0,    %pointer to returned address
            PUSHINT, 0,     %bytes
            ALLOCGLOB,
            RETURN
        )
        ops(6) := addr(ptr)
        ops(8) := bytes
        cheat(__procedure, addr(ops))()
        result ptr
    end Alloc
    
    proc Free(address: addressint)
        var __address := address
        var ops: array 1..6 of nat4 := init(
            PROC, 0,
            PUSHADDR, 0,    %address
            FREEU,
            RETURN
        )
        ops(4) := addr(__address)
        cheat(__procedure, addr(ops))()
    end Free
end Memory