unit
module InvocationSupport
    import InvocationArgument in "%oot/reflect/invocation/InvocationArgument.tu",
        LinkedArgument in "LinkedArgument.tu"
    export asLinkedArgument
    
    fcn asLinkedArgument(arg: unchecked ^InvocationArgument): unchecked ^LinkedArgument
        var linkedArg: ^LinkedArgument
        new linkedArg; linkedArg -> construct(arg);
        result linkedArg
    end asLinkedArgument
end InvocationSupport