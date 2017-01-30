unit
class SimpleStackTrace
    inherit StackTrace in "%oot/reflect/debugging/StackTrace.tu"
    import Memory in "%oot/reflect/internal/util/Memory.tu"
    export construct
    
    var stackFrames: flexible array 1..0 of unchecked ^StackFrame
    
    proc construct(__stackFrames: array 1..* of unchecked ^StackFrame)
        new stackFrames, upper(__stackFrames)
        Memory.Copy(addr(stackFrames), addr(__stackFrames), sizeof(addressint) * upper(stackFrames))
    end construct
    
    body fcn getStackFrameCount(): nat
        result upper(stackFrames)
    end getStackFrameCount
    
    body fcn getStackFrame(frameIndex: nat): unchecked ^StackFrame
        result stackFrames(frameIndex)
    end getStackFrame
    
end SimpleStackTrace