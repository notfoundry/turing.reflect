unit
class AnnotatedElement
    inherit Object in "%oot/turing/lang/Object.tu"
    import Annotation in "Annotation.tu"
    export getAnnotationCount, getAnnotation, isAnnotationPresent
    
    deferred fcn getAnnotationCount(): nat
    
    deferred fcn getAnnotationAt(position: nat): unchecked ^Annotation
    
    deferred fcn getAnnotation(annotationType: cheat addressint): unchecked ^Annotation
    
    deferred fcn isAnnotationPresent(annotationType: cheat addressint): boolean
    body fcn isAnnotationPresent(annotationType: cheat addressint): boolean
        result getAnnotation(annotationType) ~= nil
    end isAnnotationPresent
    
end AnnotatedElement