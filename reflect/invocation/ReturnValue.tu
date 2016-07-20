unit
class ReturnValue
    import Primitives in "%oot/reflect/Primitives.tu"
    export getType, getSize
    deferred fcn getType(): Primitives.TYPE
    
    deferred fcn getSize(): nat
end ReturnValue