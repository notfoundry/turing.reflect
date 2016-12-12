unit
module Intrinsics
    import Opcodes in "%oot/reflect/Opcodes.tu",
        Memory in "%oot/reflect/internal/util/Memory.tu",
        Universe in "%oot/reflect/universe",
        TFunction in "%oot/reflect/TFunction.tu"
    export getCallerCode
    
    fcn getFunctionFromWithin(internalOperationAddress: addressint): addressint
        var op := internalOperationAddress
        loop
            exit when Opcodes.TYPE @ (op) = PROC
                & Opcodes.TYPE @ (op + Opcodes.OP_SIZE * 2) = SETFILENO
                & Opcodes.TYPE @ (op + Opcodes.OP_SIZE * 5) = SETLINENO
            op -= Opcodes.OP_SIZE
        end loop
        result op
    end getFunctionFromWithin
    
    fcn getCallerCode(): unchecked ^TFunction
        quit
        quit
        quit
        quit
        quit    % each quit statement serves to pad the opcodes
        quit    % of the function so that when custom ops are
        quit    % copied to its address, we don't overwrite
        quit    % arbitrary memory
        quit
        quit
        quit
    end getCallerCode
    
    var ops: array 1..* of Opcodes.TYPE := init(
        PROC, 4,
        
        LOCATELOC, 0,
        FETCHADDR,
        FETCHADDR,      % get the address of the stack for the previously called function,
        LOCATELOC, 4,   % pop off the top of it to find fp
        ASNADDRINV,
        
        LOCATELOC, 4,
        PUSHCOPY,
        FETCHADDR,  % decrement the retrieved address by 8 to find the caller's calling code
        PUSHINT1, 8,
        SUBNAT,
        ASNNAT,
        
        PUSHADDR, 0,
        LOCATELOC, 4,
        FETCHADDR,  % determine what the address of the caller's calling function is
        FETCHADDR,
        LOCATELOC, 4,
        CALL, 8,
        INCSP, 12,
        
        PUSHADDR, 0,
        LOCATELOC, 4,   % reflect the calling function, get a TFunction instance
        PUSHCOPY,
        CALL, 8,
        INCSP, 12,
        
        LOCATELOC, 4,
        FETCHADDR,  % return the TFunction instance to the interested caller
        LOCATEPARM, 0,
        FETCHADDR,
        ASNADDRINV,
        
        RETURN
    )
    ops(19) := addr(getFunctionFromWithin)
    ops(31) := addr(reflectf)
    
    Memory.Copy(addr(getCallerCode), addr(ops), Opcodes.OP_SIZE * upper(ops))
    
end Intrinsics