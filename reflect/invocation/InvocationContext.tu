unit
class InvocationContext
    inherit Object in "%oot/turing/lang/Object.tu"
    import InvocationArgument in "%oot/reflect/invocation/InvocationArgument.tu"
    export with, do
        
    deferred fcn with(arg: unchecked ^InvocationArgument): unchecked ^InvocationContext
    
    deferred proc do()
    
end InvocationContext