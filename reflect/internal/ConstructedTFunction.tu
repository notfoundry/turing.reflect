unit
class ConstructedTFunction
    inherit TFunction in "%oot/reflect/TFunction.tu"
    import Opcodes in "%oot/reflect/Opcodes.tu",
        DefinedOpInspector in "util/DefinedOpInspector.tu",
        FunctionContext in "%oot/reflect/context/FunctionContext.tu",
        ContextFactory in "util/ContextFactory.tu"
    export construct
    
    var opcodes: flexible array 1..0 of Opcodes.TYPE
    
    var context: unchecked ^FunctionContext
    
    proc construct(var ops: array 1..* of Opcodes.TYPE)
        new opcodes, upper(ops)
        for i: 1..upper(ops)
            opcodes(i) := ops(i)
        end for
        context := ContextFactory.makeFunctionContext(addr(opcodes), false)
    end construct
    
    body fcn getContext(): unchecked ^FunctionContext
        result context
    end getContext
    
    body fcn inspect(): unchecked ^OpInspector
        var resultInspector: ^DefinedOpInspector
        new resultInspector; resultInspector -> construct(addr(opcodes), addr(opcodes(upper(opcodes))));
        result resultInspector
    end inspect
    
    body proc invoke(returnAddr: addressint, instance: unchecked ^anyclass)
        type __procedure: proc x()
        if (context -> isFunction()) then
            var tmp: array 1..* of nat := init(
                PROC, 0,
                PUSHADDR, 0,
                PUSHADDR, 0,
                CALL, 4,
                INCSP, 8,
                RETURN
            )
            tmp(4) := context -> getStartAddress()
            tmp(6) := returnAddr
            cheat(__procedure, addr(tmp))()
        else
            var tmp: array 1..* of nat := init(
                PROC, 0,
                PUSHADDR, 0,
                CALL, 0,
                INCSP, 4,
                RETURN
            )
            tmp(4) := context -> getStartAddress()
            cheat(__procedure, addr(tmp))()
        end if
    end invoke
    
end ConstructedTFunction