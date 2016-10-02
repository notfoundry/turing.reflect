unit
class AnnotationManifest
    inherit AnyRef in "%oot/reflect/AnyRef.tu"
    import Annotation in "%oot/reflect/annotation/Annotation.tu"
    export getAnnotationCount, getAnnotation
    
    deferred fcn getAnnotationCount(): nat
    
    deferred fcn getAnnotation(position: nat): unchecked ^Annotation
    
end AnnotationManifest