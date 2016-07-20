unit
class OpInspector
    export construct, hasNext, next, count, position
    
    var firstOp, lastOp, currOp: addressint
    
    proc construct(__firstOp, __lastOp: nat)
        firstOp := __firstOp; lastOp := __lastOp;
        currOp := firstOp
    end construct
    
    fcn hasNext(): boolean
        result currOp ~= lastOp+4
    end hasNext
    
    fcn next(): unchecked ^nat
        var resultPtr: unchecked ^nat
        #resultPtr := currOp
        currOp += 4
        result resultPtr
    end next
    
    fcn count(): nat
        result 1+(lastOp - firstOp) div 4
    end count
    
    fcn position(): nat
        result count() - (lastOp+4 - currOp) div 4
    end position
end OpInspector