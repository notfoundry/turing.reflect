unit
class ProxyTClass
    inherit TClass in "%oot/reflect/TClass.tu"
    export construct
    
    var this: unchecked ^TClass
    
    proc construct(backingClass: unchecked ^TClass)
        this := backingClass
    end construct
    
    
    body fcn inspect(): unchecked ^OpInspector
        result this -> inspect()
    end inspect
    
    body fcn getName(): string
        result this -> getName()
    end getName
    
    
    body fcn newInstance(): unchecked ^anyclass
        result this -> newInstance()
    end newInstance
    
    body fcn getSuperclass(): unchecked ^TClass
        result this -> getSuperclass()
    end getSuperclass
    
    body fcn getDescriptor(): TYPE
        result this -> getDescriptor()
    end getDescriptor
    
    body fcn getContext(): unchecked ^ClassContext
        result this -> getContext()
    end getContext
    
    
    body fcn getFunction(fcnNumber: nat): unchecked ^TFunction
        result this -> getFunction(fcnNumber)
    end getFunction
    
    body fcn getDeclaredFunction(fcnNumber: nat): unchecked ^TFunction
        result this -> getDeclaredFunction(fcnNumber)
    end getDeclaredFunction
    
    body fcn getFunctionCount(): nat
        result this -> getFunctionCount()
    end getFunctionCount
    
    body fcn getDeclaredFunctionCount(): nat
        result this -> getDeclaredFunctionCount()
    end getDeclaredFunctionCount
    
    
    body fcn getField(fieldNumber: nat): unchecked ^TField
        result this -> getField(fieldNumber)
    end getField
    
    body fcn getDeclaredField(fieldNumber: nat): unchecked ^TField
        result getDeclaredField(fieldNumber)
    end getDeclaredField
    
    body fcn getFieldCount(): nat
        result this -> getFieldCount()
    end getFieldCount
    
    body fcn getDeclaredFieldCount(): nat
        result this -> getDeclaredFieldCount()
    end getDeclaredFieldCount
    
    body fcn isAssignableFrom(clazz: unchecked ^TClass): boolean
        result this -> isAssignableFrom(clazz)
    end isAssignableFrom
    
    body fcn isInstance(obj: unchecked ^anyclass): boolean
        result this -> isInstance(obj)
    end isInstance
    
    
    body fcn getObjectSize(): nat
        result this -> getObjectSize()
    end getObjectSize


    body fcn getDeclaredAnnotationCount(): nat
        result this -> getDeclaredAnnotationCount()
    end getDeclaredAnnotationCount
    
    body fcn getAnnotationCount(): nat
        result this -> getAnnotationCount()
    end getAnnotationCount
    
    body fcn getDeclaredAnnotationAt(position: nat): unchecked ^Annotation
        result this -> getDeclaredAnnotationAt(position)
    end getDeclaredAnnotationAt
    
    body fcn getAnnotationAt(position: nat): unchecked ^Annotation
        result this -> getAnnotationAt(position)
    end getAnnotationAt
    
    body fcn getDeclaredAnnotation(annotationType: cheat addressint): unchecked ^Annotation
        result this -> getDeclaredAnnotation(annotationType)
    end getDeclaredAnnotation
    
    body fcn getAnnotation(annotationType: cheat addressint): unchecked ^Annotation
        result this -> getAnnotation(annotationType)
    end getAnnotation
    
    body fcn getDeclaredAnnotations(annotationType: cheat addressint): unchecked ^RepeatedAnnotation
        result this -> getDeclaredAnnotations(annotationType)
    end getDeclaredAnnotations
    
    body fcn getAnnotations(annotationType: cheat addressint): unchecked ^RepeatedAnnotation
        result this -> getAnnotations(annotationType)
    end getAnnotations
    
    body fcn isAnnotationPresent(annotationType: cheat addressint): boolean
        result this -> isAnnotationPresent(annotationType)
    end isAnnotationPresent
    

    body fcn equals(o: unchecked ^anyclass): boolean
        result this -> equals(o)
    end equals
    
end ProxyTClass