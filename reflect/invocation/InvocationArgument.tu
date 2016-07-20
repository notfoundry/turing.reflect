unit
class InvocationArgument
    export construct,
        var next, opCount, opAt, getSize, getMergeOp
    var next: unchecked ^InvocationArgument := nil
    var opSize, mergeOp: nat
    var argumentOps: flexible array 1..0 of nat
    
    proc construct(var ops: array 1..* of nat, __opSize, __mergeOp: nat)
        new argumentOps, upper(ops)
        for i: 1..upper(ops)
            argumentOps(i) := ops(i)
        end for
        opSize := __opSize
        mergeOp := __mergeOp
    end construct
    
    fcn opCount(): nat
        result upper(argumentOps)
    end opCount
    
    fcn opAt(arrIndex: nat): nat
        result argumentOps(arrIndex)
    end opAt
    
    fcn getSize(): nat
        result opSize
    end getSize
    
    fcn getMergeOp(): nat
        result mergeOp
    end getMergeOp
end InvocationArgument