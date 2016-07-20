unit
module *Invocation
    import Opcodes in "Opcodes.tu", InvocationArgument in "invocation/InvocationArgument.tu"
    export ~.*intArg, ~.*stringArg, ~.*realArg, ~.*booleanArg
    
    fcn intArg(arg: int): unchecked ^InvocationArgument
        var ops: array 1..2 of nat := init(
            Opcodes.PUSHINT1, 0
        )
        if (arg > 127) then
            if (arg > 32767) then
                ops(1) := Opcodes.PUSHINT
            else
                ops(1) := Opcodes.PUSHINT2
            end if
        end if
        ops(2) := cheat(nat, arg)
        
        var node: ^InvocationArgument
        new node; node -> construct(ops, sizeof(int), Opcodes.ASNINT4INV);
        result node
    end intArg
    
    fcn enumArg(arg: cheat nat): unchecked ^InvocationArgument
        result intArg(arg)
    end enumArg
    
    fcn realArg(arg: real): unchecked ^InvocationArgument
        var __arg := arg
        var ops: array 1..3 of nat := init(
            Opcodes.PUSHREAL, 0, 0
        )
        ops(2) := nat @ (addr(__arg))
        ops(3) := nat @ (addr(__arg)+4)
        
        var node: ^InvocationArgument
        new node; node -> construct(ops, sizeof(real), Opcodes.ASNREALINV);
        result node
    end realArg
    
    fcn stringArg(arg: string): unchecked ^InvocationArgument
        var ops: array 1..3 of nat := init(
            Opcodes.PUSHADDR1, 0, 0
        )
        ops(3) := addr(arg)
        
        var node: ^InvocationArgument
        new node; node -> construct(ops, sizeof(addressint), Opcodes.ASNADDRINV);
        result node
    end stringArg
    
    fcn booleanArg(arg: boolean): unchecked ^InvocationArgument
        var ops: array 1..1 of nat
        if (arg) then
            ops(1) := Opcodes.PUSHVAL1
        else
            ops(1) := Opcodes.PUSHVAL0
        end if
        
        var node: ^InvocationArgument
        new node; node -> construct(ops, sizeof(int), Opcodes.ASNINT4INV);
        result node
    end booleanArg
    
end Invocation