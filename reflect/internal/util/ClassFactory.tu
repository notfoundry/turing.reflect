unit
module ClassFactory
    import Opcodes in "%oot/reflect/Opcodes.tu",
        TFunction in "%oot/reflect/TFunction.tu",
        ConstructedTFunction in "%oot/reflect/internal/ConstructedTFunction.tu"
    export makeFactory
    
    fcn makeFactory(baseClass: addressint): unchecked ^TFunction
        var tmp: array 1..* of Opcodes.TYPE := init(
            PROC, 8,
            LOCATELOC, 8,
            PUSHADDR, 0,
            NEWCLASS,
            CALL, 8,
            INCSP, 12,
            ASNPTR,
            LOCATELOC, 8,
            FETCHPTR,
            LOCATEPARM, 0,
            FETCHADDR,
            ASNADDRINV,
            RETURN,
            ABORT,
            ADDSET
        )
        
        tmp(6) := baseClass
        var res: ^ConstructedTFunction
        new res; res -> construct(tmp);
        result res
    end makeFactory
    
end ClassFactory