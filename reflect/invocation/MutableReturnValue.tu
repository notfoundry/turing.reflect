unit
class MutableReturnValue
    inherit ReturnValue in "%oot/reflect/invocation/ReturnValue.tu"
    export construct
    
    var __valueType: Primitives.TYPE
    var __valueSize: nat
    
    proc construct(valueType: Primitives.TYPE, valueSize: nat)
        __valueType := valueType
        __valueSize := valueSize
    end construct
    
    body fcn getType(): Primitives.TYPE
        result __valueType
    end getType
    
    body fcn getSize(): nat
        result __valueSize
    end getSize
end MutableReturnValue