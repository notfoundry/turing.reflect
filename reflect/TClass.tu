unit
class TClass
    inherit Object in "%oot/turing/lang/Object.tu"
    import TFunction in "TFunction.tu", OpInspector in "util/OpInspector.tu", ClassContext in "context/ClassContext.tu"
    export TYPE, newInstance, getDescriptor, getSuperclass, getContext, getFunction, inspect, getName
    
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
    
    deferred fcn getFunction(procNumber: nat): unchecked ^TFunction
    
    deferred fcn inspect(): unchecked ^OpInspector
    
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