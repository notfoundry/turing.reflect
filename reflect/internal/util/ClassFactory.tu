unit
module ClassFactory
    import Opcodes in "%oot/reflect/Opcodes.tu",
        TFunction in "%oot/reflect/TFunction.tu", ConstructedTFunction in "%oot/reflect/internal/ConstructedTFunction.tu"
    export makeFactory
    
    fcn makeFactory(baseClass: addressint): unchecked ^TFunction
        var tmp: array 1..* of nat := init(
            Opcodes.PROC, 8,
            Opcodes.LOCATELOC, 8,
            Opcodes.PUSHADDR, 0,
            Opcodes.NEWCLASS,
            Opcodes.CALL, 8,
            Opcodes.INCSP, 12,
            Opcodes.ASNPTR,
            Opcodes.LOCATELOC, 8,
            Opcodes.FETCHPTR,
            Opcodes.LOCATEPARM, 0,
            Opcodes.FETCHADDR,
            Opcodes.ASNADDRINV,
            Opcodes.RETURN,
            Opcodes.ABORT,
            Opcodes.ADDSET
        )
        
        tmp(6) := baseClass
        var res: ^ConstructedTFunction
        new res; res -> construct(tmp);
        result res
    end makeFactory
    
end ClassFactory