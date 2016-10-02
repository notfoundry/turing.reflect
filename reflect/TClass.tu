unit
class TClass
    inherit AnnotatedElement in "annotation/AnnotatedElement.tu"
    import TFunction in "TFunction.tu",
        TField in "TField.tu",
        OpInspector in "util/OpInspector.tu",
        ClassContext in "context/ClassContext.tu"
    export TYPE, inspect, newInstance, getDescriptor, getSuperclass, getContext, getFunction, getName, getObjectSize, getFunctionCount, getField, getFieldCount, getDeclaredFunction, getDeclaredFunctionCount, getDeclaredField, getDeclaredFieldCount, isAssignableFrom, isInstance
    
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
    
    deferred fcn inspect(): unchecked ^OpInspector
    
    deferred fcn getName(): string
    
    deferred fcn newInstance(): unchecked ^anyclass
    
    deferred fcn getSuperclass(): unchecked ^TClass
    
    deferred fcn getDescriptor(): TYPE
    
    deferred fcn getContext(): unchecked ^ClassContext
    
    
    deferred fcn getFunction(fcnNumber: nat): unchecked ^TFunction
    
    deferred fcn getDeclaredFunction(fcnNumber: nat): unchecked ^TFunction
    
    deferred fcn getFunctionCount(): nat
    
    deferred fcn getDeclaredFunctionCount(): nat
    
    
    deferred fcn getField(fieldNumber: nat): unchecked ^TField
    
    deferred fcn getDeclaredField(fieldNumber: nat): unchecked ^TField
    
    deferred fcn getFieldCount(): nat
    
    deferred fcn getDeclaredFieldCount(): nat
    
    
    deferred fcn isAssignableFrom(clazz: unchecked ^TClass): boolean
    
    deferred fcn isInstance(obj: unchecked ^anyclass): boolean
    
    
    deferred fcn getObjectSize(): nat
    body fcn getObjectSize(): nat
        result getDescriptor().objSize
    end getObjectSize

    body fcn equals(o: unchecked ^anyclass): boolean
        if (o ~= nil & objectclass(o) >= objectclass(self)) then
            result getDescriptor().baseClass = TClass(o).getDescriptor().baseClass
        else result false
        end if
    end equals
    
end TClass