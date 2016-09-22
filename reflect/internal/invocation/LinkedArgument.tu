unit
class LinkedArgument
    inherit Object in "%oot/turing/lang/Object.tu"
    import InvocationArgument in "%oot/reflect/invocation/InvocationArgument.tu"
    export var next, arg, construct
    
    var arg: unchecked ^InvocationArgument
    
    var next: unchecked ^LinkedArgument := nil
    
    proc construct(__arg: unchecked ^InvocationArgument)
        arg := __arg
    end construct
    
end LinkedArgument