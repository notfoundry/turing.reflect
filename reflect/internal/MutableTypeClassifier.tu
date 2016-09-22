unit
class MutableTypeClassifier
    inherit TypeClassifier in "%oot/reflect/TypeClassifier.tu"
    export construct
    
    var valueType: Primitives.TYPE
    
    var valueSize: nat
    
    proc construct(__valueType: Primitives.TYPE, __valueSize: nat)
        valueType := __valueType
        valueSize := __valueSize
    end construct
    
    body fcn getType(): Primitives.TYPE
        result valueType
    end getType
    
    body fcn getSize(): nat
        result valueSize
    end getSize
    
end MutableTypeClassifier