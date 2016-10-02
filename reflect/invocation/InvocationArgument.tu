unit
class InvocationArgument
    inherit AnyRef in "%oot/reflect/AnyRef.tu"
    import Opcodes in "%oot/reflect/Opcodes.tu"
    export opCount, opAt, getSize
    
    deferred fcn opCount(): nat
    
    deferred fcn opAt(arrIndex: nat): Opcodes.TYPE
    
    deferred fcn getSize(): nat
    
end InvocationArgument