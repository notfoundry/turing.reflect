unit
class SimpleStackFrame
    inherit StackFrame in "%oot/reflect/debugging/StackFrame.tu"
    export construct
    
    var calledFunction: unchecked ^TFunction
    
    var containerClass: unchecked ^TClass
    
    var lineNumber: nat
    
    var exitLocation: addressint
    
    proc construct(__calledFunction: unchecked ^TFunction, __containerClass: unchecked ^TClass, __lineNumber: nat, __exitLocation: addressint)
        calledFunction := __calledFunction
        containerClass := __containerClass
        lineNumber := __lineNumber
        exitLocation := __exitLocation
    end construct
    
    body fcn getCalledFunction(): unchecked ^TFunction
        result calledFunction
    end getCalledFunction
    
    body fcn getContainingClass(): unchecked ^TClass
        result containerClass
    end getContainingClass
    
    body fcn getLineNumber(): nat
        result lineNumber
    end getLineNumber
    
    body fcn getExitLocation(): addressint
        result exitLocation
    end getExitLocation
    
end SimpleStackFrame