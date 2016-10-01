unit
class DefaultInvocationContext
    inherit InvocationContext in "%oot/reflect/invocation/InvocationContext.tu"
    import InvocationArgument in "%oot/reflect/invocation/InvocationArgument.tu",
        TFunction in "%oot/reflect/TFunction.tu",
        Opcodes in "%oot/reflect/Opcodes.tu"
    export construct
    
    const BASE_INVOCATION_OP_COUNT := 4
    
    var func: unchecked ^TFunction
    
    var returnAddress: addressint
    
    var instance: unchecked ^anyclass
    
    var ops: flexible array 1..BASE_INVOCATION_OP_COUNT of Opcodes.TYPE
    
    var args: flexible array 1..0 of unchecked ^InvocationArgument
    
    proc construct(__func: unchecked ^TFunction, __returnAddress: addressint, __instance: unchecked ^anyclass)
        ops(1) := PROC
        ops(2) := 0
        ops(3) := PUSHADDR
        ops(4) := __func -> getContext() -> getStartAddress()
        
        func := __func
        returnAddress := __returnAddress
        instance := __instance
    end construct
    
    body fcn with(arg: unchecked ^InvocationArgument): unchecked ^InvocationContext
        new args, upper(args) + 1
        args(upper(args)) := arg
        result self
    end with
    
    body proc do()
        type __procedure: proc x()
        var callsiteIncrement := 0
        
        for decreasing i: upper(args)..1
            const argOpCount := args(i) -> opCount()
            const oldOpCont := upper(ops)
            
            new ops, oldOpCont + argOpCount
            
            for j: 1..argOpCount
                ops(oldOpCont+j) := args(i) -> opAt(j)
            end for
            
            callsiteIncrement += args(i) -> getSize()
        end for
        
        if (func -> getContext() -> isFunction()) then
            const oldOpCont := upper(ops)
            new ops, upper(ops) + 2
            
            ops(oldOpCont+1) := PUSHADDR
            ops(oldOpCont+2) := returnAddress
            
            callsiteIncrement += Opcodes.OP_SIZE
        end if
        
        if (func -> getContext() -> isInClass()) then
            const oldOpCont := upper(ops)
            new ops, upper(ops) + 2
            
            ops(oldOpCont+1) := PUSHADDR
            ops(oldOpCont+2) := #instance
            
            callsiteIncrement += Opcodes.OP_SIZE
        end if
        
        const oldOpCont := upper(ops)
        new ops, upper(ops) + 5
        
        ops(oldOpCont+1) := CALL
        ops(oldOpCont+2) := callsiteIncrement
        ops(oldOpCont+3) := INCSP
        ops(oldOpCont+4) := callsiteIncrement + Opcodes.OP_SIZE
        ops(oldOpCont+5) := RETURN
        
        cheat(__procedure, addr(ops))()
    end do
end DefaultInvocationContext