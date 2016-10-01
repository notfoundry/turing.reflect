unit
class MutableInvocationArgument
    inherit InvocationArgument in "%oot/reflect/invocation/InvocationArgument.tu"
    import Opcodes in "%oot/reflect/Opcodes.tu"
    export construct
    
    var argSize: nat
    
    var argumentOps: flexible array 1..0 of Opcodes.TYPE
    
    proc construct(var ops: array 1..* of Opcodes.TYPE, __argSize: nat)
        new argumentOps, upper(ops)
        for i: 1..upper(ops)
            argumentOps(i) := ops(i)
        end for
        argSize := __argSize
    end construct
    
    body fcn opCount(): nat
        result upper(argumentOps)
    end opCount
    
    body fcn opAt(arrIndex: nat): Opcodes.TYPE
        result argumentOps(arrIndex)
    end opAt
    
    body fcn getSize(): nat
        result argSize
    end getSize
    
end MutableInvocationArgument