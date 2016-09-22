unit
class OpInspector
    import Opcodes in "%oot/reflect/Opcodes.tu"
    export hasNext, next, count, position
    
    deferred fcn hasNext(): boolean
    
    deferred fcn next(): unchecked ^Opcodes.TYPE
    
    deferred fcn count(): nat
    
    deferred fcn position(): nat
end OpInspector