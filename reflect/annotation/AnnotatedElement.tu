unit
class AnnotatedElement
    inherit Object in "%oot/turing/lang/Object.tu"
    import Annotation in "Annotation.tu",
        RepeatedAnnotation in "RepeatedAnnotation.tu"
    export getDeclaredAnnotationCount, getAnnotationCount, getDeclaredAnnotationAt, getAnnotationAt, getDeclaredAnnotation, getAnnotation, getDeclaredAnnotations, getAnnotations, isAnnotationPresent
    
    deferred fcn getDeclaredAnnotationCount(): nat
    
    deferred fcn getAnnotationCount(): nat
    
    deferred fcn getDeclaredAnnotationAt(position: nat): unchecked ^Annotation
    
    deferred fcn getAnnotationAt(position: nat): unchecked ^Annotation
    
    deferred fcn getDeclaredAnnotation(annotationType: cheat addressint): unchecked ^Annotation
    
    deferred fcn getAnnotation(annotationType: cheat addressint): unchecked ^Annotation
    
    deferred fcn getDeclaredAnnotations(annotationType: cheat addressint): unchecked ^RepeatedAnnotation
    
    deferred fcn getAnnotations(annotationType: cheat addressint): unchecked ^RepeatedAnnotation
    
    deferred fcn isAnnotationPresent(annotationType: cheat addressint): boolean
    body fcn isAnnotationPresent(annotationType: cheat addressint): boolean
        result getDeclaredAnnotation(annotationType) ~= nil
    end isAnnotationPresent
    
end AnnotatedElement