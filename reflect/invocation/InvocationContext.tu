unit
class InvocationContext
    inherit AnyRef in "%oot/reflect/AnyRef.tu"
    import InvocationArgument in "%oot/reflect/invocation/InvocationArgument.tu"
    export with, do
        
    deferred fcn with(arg: unchecked ^InvocationArgument): unchecked ^InvocationContext
    
    deferred proc do()
    
end InvocationContext