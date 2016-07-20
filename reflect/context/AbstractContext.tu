unit
class AbstractContext
    inherit Object in "%oot/turing/lang/Object.tu"
    export getStartAddress, getEndAddress, getSourceLength, getOpCount
    
    var startAddress, endAddress: addressint
    var sourceLength, opCount: nat
    
    fcn getStartAddress(): addressint
        result startAddress
    end getStartAddress
    
    fcn getEndAddress(): addressint
        result endAddress
    end getEndAddress
    
    fcn getSourceLength(): nat
        result sourceLength
    end getSourceLength
    
    fcn getOpCount(): nat
        result opCount
    end getOpCount
    
    body fcn equals(o: ^Object): boolean
        if (o ~= nil & objectclass(self) = objectclass(o)) then
            result getStartAddress() = AbstractContext(o).getStartAddress()
        else result false
        end if
    end equals
end AbstractContext