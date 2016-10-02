unit
class CodeContext
    inherit AnyRef in "%oot/reflect/AnyRef.tu"
    export getStartAddress, getEndAddress, getSourceLength, getOpCount
    
    deferred fcn getStartAddress(): addressint
    
    deferred fcn getEndAddress(): addressint
    
    deferred fcn getSourceLength(): nat
    
    deferred fcn getOpCount(): nat
end CodeContext