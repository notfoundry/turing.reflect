unit
class ClassContext
    inherit AbstractContext in "AbstractContext.tu"
    export construct

    proc construct(__startAddress, __endAddress: addressint,
            __sourceLength, __opCount: nat)
        
        startAddress := __startAddress
        endAddress := __endAddress
        sourceLength := __sourceLength
        opCount := __opCount
    end construct
    
end ClassContext