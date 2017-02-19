unit
class StackTrace
    import StackFrame in "StackFrame.tu"
    export getStackFrameCount, getStackFrame, printStackTrace
    
    deferred fcn getStackFrameCount(): nat
    
    deferred fcn getStackFrame(frameIndex: nat): unchecked ^StackFrame
    
    proc printStackTrace()
        put "Current process stack trace:\n"..
        
        for i: 1..getStackFrameCount()
            const frame := getStackFrame(i) -> getContainingClass()
        end for
        
        for i: 1..getStackFrameCount()
            const frame := getStackFrame(i)
            const calledFunction := frame -> getCalledFunction()
            const containingClass := frame -> getContainingClass()
            
            var context: string
            if (containingClass = nil) then
                context := "<global>"
            else
                context := containingClass -> getName()
            end if
            
            var address: string
            if (calledFunction ~= nil) then
                address := "0x" + natstr(calledFunction -> getContext() -> getStartAddress(), 0, 16)
            else
                address := "<unknown>"
            end if
            
            put i, " - @", context, ".", address, " (File ", 0, ", Line ", frame -> getLineNumber(), ")"
        end for
    end printStackTrace
end StackTrace