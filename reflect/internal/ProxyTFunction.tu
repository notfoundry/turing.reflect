unit
class ProxyTFunction
    inherit TFunction in "%oot/reflect/TFunction.tu"
    export construct
    
    var this: unchecked ^TFunction
    
    proc construct(backingFunction: unchecked ^TFunction)
        this := backingFunction
    end construct
    
    
    body fcn inspect(): unchecked ^OpInspector
        result this -> inspect()
    end inspect
    
    body fcn getContext(): unchecked ^FunctionContext
        result this -> getContext()
    end getContext
    
    body proc invoke(returnAddr: addressint, instance: unchecked ^anyclass)
        this -> invoke(returnAddr, instance)
    end invoke
    
    body fcn invokeArgs(returnAddr: addressint, instance: unchecked ^anyclass): unchecked ^InvocationContext
        result this -> invokeArgs(returnAddr, instance)
    end invokeArgs
    
    body fcn getReturnType(): unchecked ^TypeClassifier
        result this -> getReturnType()
    end getReturnType
    
    
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
    
end ProxyTFunction