unit
class StackFrame
    import TFunction in "%oot/reflect/TFunction.tu",
        TClass in "%oot/reflect/TClass.tu"
    export getCalledFunction, getContainingClass, getLineNumber
    
    deferred fcn getCalledFunction(): unchecked ^TFunction
    
    deferred fcn getContainingClass(): unchecked ^TClass
    
    deferred fcn getLineNumber(): nat
end StackFrame