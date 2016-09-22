unit
class DeclaredClassContext
    inherit ClassContext in "%oot/reflect/context/ClassContext.tu"
    export construct

    var startAddress, endAddress: addressint
    
    var sourceLength, opCount: nat

    proc construct(__startAddress, __endAddress: addressint,
            __sourceLength, __opCount: nat)
        
        startAddress := __startAddress
        endAddress := __endAddress
        sourceLength := __sourceLength
        opCount := __opCount
    end construct
    
    body fcn getStartAddress(): addressint
        result startAddress
    end getStartAddress
    
    body fcn getEndAddress(): addressint
        result endAddress
    end getEndAddress
    
    body fcn getSourceLength(): nat
        result sourceLength
    end getSourceLength
    
    body fcn getOpCount(): nat
        result opCount
    end getOpCount
    
    body fcn equals(o: ^Object): boolean
        if (o ~= nil & objectclass(o) >= ClassContext) then
            result getStartAddress() = ClassContext(o).getStartAddress()
        else result false
        end if
    end equals
    
end DeclaredClassContext