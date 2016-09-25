unit
class ConstructedTFunction
    inherit TFunction in "%oot/reflect/TFunction.tu"
    import Opcodes in "%oot/reflect/Opcodes.tu",
        DefinedOpInspector in "util/DefinedOpInspector.tu",
        FunctionContext in "%oot/reflect/context/FunctionContext.tu",
        ReflectionFactory in "util/ReflectionFactory.tu"
    export construct
    
    var opcodes: flexible array 1..0 of Opcodes.TYPE
    
    var context: unchecked ^FunctionContext
    
    proc construct(var ops: array 1..* of Opcodes.TYPE)
        new opcodes, upper(ops)
        for i: 1..upper(ops)
            opcodes(i) := ops(i)
        end for
        context := ReflectionFactory.makeFunctionContext(addr(opcodes), false)
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
        var it := inspect()
        var tmp: array 1..it -> count() of nat
        var ind := 1
        loop
            exit when ~it -> hasNext()
            var op := it -> next()
            if (^op = LOCATEPARM & nat @ (#op+4) = 0) then
                tmp(ind) := PUSHADDR;
                tmp(ind+1) := returnAddr;
                ind += 2
                for i: 1..2
                    if (it -> hasNext()) then
                        op := it -> next()
                    end if
                end for
            else
                tmp(ind) := ^op
                ind += 1
            end if
        end loop
        cheat(__procedure, addr(tmp))()
    end invoke
    
end ConstructedTFunction