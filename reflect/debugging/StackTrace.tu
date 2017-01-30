unit
class StackTrace
    import StackFrame
    export getStackFrameCount, getStackFrame
    
    deferred fcn getStackFrameCount(): nat
    
    deferred fcn getStackFrame(frameIndex: nat): unchecked ^StackFrame
end StackTrace