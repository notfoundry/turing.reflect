class StackFrame
    import TFunction, TClass
    export getCalledFunction, getContainingClass, getLineNumber
    
    deferred fcn getCalledFunction(): unchecked ^TFunction
    
    deferred fcn getContainingClass(): unchecked ^TClass
    
    deferred fcn getLineNumber(): nat
end StackFrame