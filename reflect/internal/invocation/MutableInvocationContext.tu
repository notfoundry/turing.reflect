unit
class MutableInvocationContext
    inherit InvocationContext in "%oot/reflect/invocation/InvocationContext.tu"
    import InvocationArgument in "%oot/reflect/invocation/InvocationArgument.tu",
        MutableInvocationArgument in "MutableInvocationArgument.tu",
        Opcodes in "%oot/reflect/Opcodes.tu",
        FunctionContext in "%oot/reflect/context/FunctionContext.tu",
        LinkedArgument in "LinkedArgument.tu",
        InvocationSupport in "InvocationSupport.tu"
    export construct
    
    const ARRAY_EXPANSION_SIZE := 6
    
    var argHead, argTail: ^LinkedArgument := nil
    
    var argCount, opPosition: nat := 0
    
    var invocationOps: flexible array 1..10 of Opcodes.TYPE
    
    proc setNextOp(op: Opcodes.TYPE)
        opPosition += 1
        if (opPosition > upper(invocationOps)) then
            new invocationOps, upper(invocationOps)+ARRAY_EXPANSION_SIZE
        end if
        invocationOps(opPosition) := op
    end setNextOp
    
    proc appendTailArg(arg: unchecked ^InvocationArgument)
        if (argHead = nil) then
            argHead := InvocationSupport.asLinkedArgument(arg)
            argTail := argHead
        else
            argTail -> next := InvocationSupport.asLinkedArgument(arg)
            argTail := argTail -> next
        end if
    end appendTailArg
    
    proc prepFunctionCall(returnAddr: addressint)
        argCount += 1
        var ops: array 1..2 of Opcodes.TYPE := init(
            PUSHADDR, 0
        )
        ops(2) := returnAddr
        
        var node: ^MutableInvocationArgument
        new node; node -> construct(ops, 4, ABORT);
        appendTailArg(node)
    end prepFunctionCall
    
    proc prepClassCall(instanceAddr: addressint)
        argCount += 1
        var ops: array 1..* of Opcodes.TYPE := init(
            PUSHADDR, 0
        )
        ops(2) := instanceAddr
        
        var node: ^MutableInvocationArgument
        new node; node -> construct(ops, 4, ASNINT4INV);
        appendTailArg(node)
    end prepClassCall
    
    proc construct(procContext: unchecked ^FunctionContext, returnAddr, instanceAddr: addressint)
        if (procContext -> isFunction()) then
            prepFunctionCall(returnAddr)
        end if
        if (procContext -> isInClass()) then
            prepClassCall(instanceAddr)
        end if
        setNextOp(PROC)
        setNextOp(0)
        setNextOp(PUSHADDR1)
        setNextOp(0)
        setNextOp(procContext -> getStartAddress())
    end construct
    
    body fcn with(arg: unchecked ^InvocationArgument): unchecked ^InvocationContext
        argCount += 1
        appendTailArg(arg)
        result self
    end with
    
    body proc do()
        type __procedure: proc x()
        
        var callSite := 0
        if (argCount > 0) then
            setNextOp(Opcodes.DECSP)
            setNextOp(0)
            var spIndex := opPosition
            
            var node := argHead
            var insPos := 0
            loop
                exit when node = nil
                const curr := node -> arg
                insPos += 1
                callSite += curr -> getSize()
                
                for i: 1..curr -> opCount()
                    setNextOp(curr -> opAt(i))
                end for
                if (insPos > 1) then
                    setNextOp(LOCATEARG)
                    setNextOp(callSite)
                    setNextOp(curr -> getMergeOp())
                end if
                
                node := node -> next
            end loop
            invocationOps(spIndex) := callSite - Opcodes.OP_SIZE
        end if
        
        setNextOp(CALL)
        setNextOp(callSite)
        setNextOp(INCSP)
        setNextOp(callSite+Opcodes.OP_SIZE)
        setNextOp(RETURN)

        cheat(__procedure, addr(invocationOps))()
    end do
end MutableInvocationContext