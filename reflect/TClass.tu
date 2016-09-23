unit
class TClass
    inherit CodeConstruct in "CodeConstruct.tu"
    import TFunction in "TFunction.tu",
        TField in "TField.tu",
        OpInspector in "util/OpInspector.tu",
        ClassContext in "context/ClassContext.tu"
    export TYPE, newInstance, getDescriptor, getSuperclass, getContext, getFunction, getName, getObjectSize, getFunctionCount, getField, getFieldCount
    
    type TYPE:
        record
            baseClass: addressint
            expandClass: addressint
            attributes: nat4
            objSize: nat4
            classId: addressint
            initRoutine: addressint
            numOperations: nat4
        end record
    
    deferred fcn getName(): string
    
    deferred fcn newInstance(): unchecked ^anyclass
    
    deferred fcn getSuperclass(): unchecked ^TClass
    
    deferred fcn getDescriptor(): TYPE
    
    deferred fcn getContext(): unchecked ^ClassContext
    
    deferred fcn getFunction(fcnNumber: nat): unchecked ^TFunction
    
    deferred fcn getFunctionCount(): nat
    
    deferred fcn getField(fieldNumber: nat): unchecked ^TField
    
    deferred fcn getFieldCount(): nat
    
    deferred fcn getObjectSize(): nat
    body fcn getObjectSize(): nat
        result getDescriptor().objSize
    end getObjectSize
    
    body fcn toString(): string
        result "class " + getName()
    end toString
    
    body fcn equals(o: ^Object): boolean
        if (o ~= nil & objectclass(self) = objectclass(o)) then
            result getDescriptor().baseClass = TClass(o).getDescriptor().baseClass
        else result false
        end if
    end equals
    
end TClass