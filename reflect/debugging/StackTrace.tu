unit
class StackTrace
    import StackFrame in "StackFrame.tu"
    export getStackFrameCount, getStackFrame
    
    deferred fcn getStackFrameCount(): nat
    
    deferred fcn getStackFrame(frameIndex: nat): unchecked ^StackFrame
end StackTrace