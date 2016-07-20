unit
class InvocationContext
    import InvocationArgument in "%oot/reflect/invocation/InvocationArgument.tu",
        Opcodes in "%oot/reflect/Opcodes.tu",
        FunctionContext in "%oot/reflect/context/FunctionContext.tu"
    export construct,
        with, do
    
    const OP_SIZE := sizeof(nat)
    const ARRAY_EXPANSION_SIZE := 6
    
    var argHead, argTail: ^InvocationArgument := nil
    var argCount, opPosition: nat := 0
    var invocationOps: flexible array 1..10 of nat
    
    proc setNextOp(op: nat)
        opPosition += 1
        if (opPosition > upper(invocationOps)) then
            new invocationOps, upper(invocationOps)+ARRAY_EXPANSION_SIZE
        end if
        invocationOps(opPosition) := op
    end setNextOp
    
    proc appendTailArg(arg: unchecked ^InvocationArgument)
        if (argHead = nil) then
            argHead := arg
            argTail := argHead
        else
            argTail -> next := arg
            argTail := argTail -> next
        end if
    end appendTailArg
    
    proc prepFunctionCall(returnAddr: addressint)
        argCount += 1
        var ops: array 1..2 of nat := init(
            Opcodes.PUSHADDR, 0
        )
        ops(2) := returnAddr
        
        var node: ^InvocationArgument
        new node; node -> construct(ops, 4, Opcodes.ABORT);
        appendTailArg(node)
    end prepFunctionCall
    
    proc prepClassCall(instanceAddr: addressint)
        argCount += 1
        var ops: array 1..* of nat := init(
            Opcodes.PUSHADDR, 0
        )
        ops(2) := instanceAddr
        
        var node: ^InvocationArgument
        new node; node -> construct(ops, 4, Opcodes.ASNINT4INV);
        appendTailArg(node)
    end prepClassCall
    
    proc construct(procContext: unchecked ^FunctionContext, returnAddr, instanceAddr: addressint)
        if (procContext -> isFunction()) then
            prepFunctionCall(returnAddr)
        end if
        if (procContext -> isInClass()) then
            prepClassCall(instanceAddr)
        end if
        setNextOp(Opcodes.PROC)
        setNextOp(0)
        setNextOp(Opcodes.PUSHADDR1)
        setNextOp(0)
        setNextOp(procContext -> getStartAddress())
    end construct
    
    fcn with(arg: unchecked ^InvocationArgument): unchecked ^InvocationContext
        argCount += 1
        appendTailArg(arg)
        result self
    end with
    
    proc do()
        type __procedure: proc x()
        
        var callSite := 0
        if (argCount > 0) then
            setNextOp(Opcodes.DECSP)
            setNextOp(0)
            var spIndex := opPosition
            
            var curr := argHead
            var insPos := 0
            loop
                exit when curr = nil
                insPos += 1
                callSite += curr -> getSize()
                
                for i: 1..curr -> opCount()
                    setNextOp(curr -> opAt(i))
                end for
                    if (insPos > 1) then
                    setNextOp(Opcodes.LOCATEARG)
                    setNextOp(callSite)
                    setNextOp(curr -> getMergeOp())
                end if
                
                curr := curr -> next
            end loop
            invocationOps(spIndex) := callSite - OP_SIZE
        end if
        
        setNextOp(Opcodes.CALL)
        setNextOp(callSite)
        setNextOp(Opcodes.INCSP)
        setNextOp(callSite+OP_SIZE)
        setNextOp(Opcodes.RETURN)

        cheat(__procedure, addr(invocationOps(1)))()
    end do
end InvocationContext