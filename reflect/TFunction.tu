unit
class TFunction
    inherit Object in "%oot/turing/lang/Object.tu"
    import OpInspector in "util/OpInspector.tu", InvocationContext in "invocation/InvocationContext.tu",
        FunctionContext in "context/FunctionContext.tu", ReturnValue in "invocation/ReturnValue.tu"
    export fetch, inspect, invoke, invokeArgs, getContext, getReturnType
    
    deferred fcn fetch(): addressint
    
    deferred fcn inspect(): unchecked ^OpInspector
    
    deferred fcn getContext(): unchecked ^FunctionContext
    
    deferred proc invoke(returnAddr: addressint)
    
    deferred fcn invokeArgs(returnAddr, instanceAddr: addressint): unchecked ^InvocationContext
    
    deferred fcn getReturnType(): unchecked ^ReturnValue
    
    body fcn equals(o: ^Object): boolean
        if (o ~= nil & objectclass(self) = objectclass(o)) then
            result fetch() = TFunction(o).fetch()
        else result false
        end if
    end equals
end TFunction