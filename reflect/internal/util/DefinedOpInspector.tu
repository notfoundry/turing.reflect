unit
class DefinedOpInspector
    inherit OpInspector in "%oot/reflect/util/OpInspector.tu"
    export construct
    
    var firstOp, lastOp, currOp: addressint
    
    proc construct(__firstOp, __lastOp: addressint)
        firstOp := __firstOp; lastOp := __lastOp;
        currOp := firstOp
    end construct
    
    body fcn hasNext(): boolean
        result currOp ~= lastOp+Opcodes.OP_SIZE
    end hasNext
    
    body fcn next(): unchecked ^Opcodes.TYPE
        var resultPtr: unchecked ^Opcodes.TYPE
        #resultPtr := currOp
        currOp += Opcodes.OP_SIZE
        result resultPtr
    end next
    
    body fcn count(): nat
        result 1+(lastOp - firstOp) div Opcodes.OP_SIZE
    end count
    
    body fcn position(): nat
        result count() - (lastOp+Opcodes.OP_SIZE - currOp) div Opcodes.OP_SIZE
    end position
end DefinedOpInspector