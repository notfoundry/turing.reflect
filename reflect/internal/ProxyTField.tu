unit
class ProxyTField
    inherit TField in "%oot/reflect/TField.tu"
    export construct
    
    var this: unchecked ^TField
    
    proc construct(backingField: unchecked ^TField)
        this := backingField
    end construct
    
    
    body fcn fetch(instance: unchecked ^anyclass): addressint
        result this -> fetch(instance)
    end fetch
    
    body fcn getInitializer(): addressint
        result this -> getInitializer()
    end getInitializer
    
    body fcn getType(): Primitives.TYPE
        result this -> getType()
    end getType
    
    
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
    
end ProxyTField