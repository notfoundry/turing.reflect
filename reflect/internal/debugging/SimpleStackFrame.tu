unit
class SimpleStackFrame
    inherit StackFrame in "%oot/reflect/debugging/StackFrame.tu"
    export construct
    
    var calledFunction: unchecked ^TFunction
    
    var containerClass: unchecked ^TClass
    
    var lineNumber: nat
    
    proc construct(__calledFunction: unchecked ^TFunction, __containerClass: unchecked ^TClass, __lineNumber: nat)
        calledFunction := __calledFunction
        containerClass := __containerClass
        lineNumber := __lineNumber
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
    
end SimpleStackFrame