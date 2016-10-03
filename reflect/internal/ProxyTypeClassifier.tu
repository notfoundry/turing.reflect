unit
class ProxyTypeClassifier
    inherit TypeClassifier in "%oot/reflect/TypeClassifier.tu"
    export construct
    
    var this: unchecked ^TypeClassifier
    
    proc construct(backingType: unchecked ^TypeClassifier)
        this := backingType
    end construct
    
    
    body fcn getType(): Primitives.TYPE
        result this -> getType()
    end getType
    
    body fcn getSize(): nat
        result this -> getSize()
    end getSize
    
end ProxyTypeClassifier