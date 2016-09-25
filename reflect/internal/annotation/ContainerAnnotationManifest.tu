unit
class ContainerAnnotationManifest
    inherit AnnotationManifest in "AnnotationManifest.tu"
    import TClass in "%oot/reflect/TClass.tu"
    export construct
    
    proc construct(clazz: unchecked ^TClass)
    
    end construct
    
end ContainerAnnotationManifest