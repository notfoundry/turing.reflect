unit
class StackFrame
    import TFunction in "%oot/reflect/TFunction.tu",
        TClass in "%oot/reflect/TClass.tu"
    export getCalledFunction, getContainingClass, getLineNumber, getExitLocation
    
    deferred fcn getCalledFunction(): unchecked ^TFunction
    
    deferred fcn getContainingClass(): unchecked ^TClass
    
    deferred fcn getLineNumber(): nat
    
    deferred fcn getExitLocation(): addressint
end StackFrame