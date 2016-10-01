unit
class TFunction
    inherit AnnotatedElement in "annotation/AnnotatedElement.tu"
    import OpInspector in "util/OpInspector.tu",
        InvocationContext in "invocation/InvocationContext.tu",
        FunctionContext in "context/FunctionContext.tu",
        TypeClassifier in "TypeClassifier.tu",
        AnnotatedElement in "annotation/AnnotatedElement.tu"
    export inspect, invoke, invokeArgs, getContext, getReturnType
    
    deferred fcn inspect(): unchecked ^OpInspector

    deferred fcn getContext(): unchecked ^FunctionContext
    
    deferred proc invoke(returnAddr: addressint, instance: unchecked ^anyclass)
    
    deferred fcn invokeArgs(returnAddr: addressint, instance: unchecked ^anyclass): unchecked ^InvocationContext
    
    deferred fcn getReturnType(): unchecked ^TypeClassifier
    
    body fcn equals(o: ^Object): boolean
        if (o ~= nil & objectclass(o) >= objectclass(self)) then
            result getContext() -> getStartAddress() = TFunction(o).getContext() -> getStartAddress()
        else result false
        end if
    end equals
end TFunction