unit
class TFunction
    inherit CodeConstruct in "CodeConstruct.tu"
    import OpInspector in "util/OpInspector.tu",
        InvocationContext in "invocation/InvocationContext.tu",
        FunctionContext in "context/FunctionContext.tu",
        TypeClassifier in "TypeClassifier.tu",
        AnnotatedElement in "annotation/AnnotatedElement.tu"
    export fetch, invoke, invokeArgs, getContext, getReturnType, getAnnotations
    
    deferred fcn fetch(): addressint
    
    deferred fcn getContext(): unchecked ^FunctionContext
    
    deferred proc invoke(returnAddr: addressint, instance: unchecked ^anyclass)
    
    deferred fcn invokeArgs(returnAddr, instanceAddr: addressint): unchecked ^InvocationContext
    
    deferred fcn getReturnType(): unchecked ^TypeClassifier
    
    deferred fcn getAnnotations(): unchecked ^AnnotatedElement
    
    body fcn equals(o: ^Object): boolean
        if (o ~= nil & objectclass(self) = objectclass(o)) then
            result fetch() = TFunction(o).fetch()
        else result false
        end if
    end equals
end TFunction