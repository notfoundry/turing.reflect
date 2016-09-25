unit
class DeclaredTField
    inherit TField in "%oot/reflect/TField.tu"
    import AnnotationFactory in "annotation/AnnotationFactory.tu",
        AnnotationManifest in "annotation/AnnotationManifest.tu",
        MutableRepeatedAnnotation in "annotation/MutableRepeatedAnnotation.tu"
    export construct
    
    var fieldOffset: nat
    
    var fieldType: Primitives.TYPE
    
    var initializer: addressint
    
    var annotations: unchecked ^AnnotationManifest := nil
    
    proc construct(__fieldOffset: nat, __fieldType: Primitives.TYPE, __initializer: addressint)
        fieldOffset := __fieldOffset
        fieldType := __fieldType
        initializer := __initializer
    end construct
    
    body fcn fetch(instance: unchecked ^anyclass): addressint
        result #instance + fieldOffset
    end fetch
    
    body fcn getInitializer(): addressint
        result initializer
    end getInitializer
    
    body fcn getType(): Primitives.TYPE
        result fieldType
    end getType
    
    body fcn getDeclaredAnnotationCount(): nat
        if (annotations = nil) then
            annotations := AnnotationFactory.getFieldAnnotations(self)
        end if
        result annotations -> getAnnotationCount()
    end getDeclaredAnnotationCount
    
    body fcn getAnnotationCount(): nat
        result getDeclaredAnnotationCount()
    end getAnnotationCount
    
    body fcn getDeclaredAnnotationAt(position: nat): unchecked ^Annotation
        const count := getDeclaredAnnotationCount()
        if (position > count) then
            Error.Halt("Tried to access annotation #" + natstr(position)
                + ", but this construct only has " + natstr(count) + " annotations")
        elsif (position = 0) then
            Error.Halt("Function annotation access is one-indexed, annotation 0 cannot be accessed")
        end if
        
        result annotations -> getAnnotation(position)
    end getDeclaredAnnotationAt
    
    body fcn getAnnotationAt(position: nat): unchecked ^Annotation
        result getDeclaredAnnotationAt(position)
    end getAnnotationAt
    
    body fcn getDeclaredAnnotation(annotationType: cheat addressint): unchecked ^Annotation
        for i: 1..getDeclaredAnnotationCount()
            const lookup := annotations -> getAnnotation(i)
            if (lookup -> isInstance(annotationType)) then
                result lookup
            end if
        end for
        result nil
    end getDeclaredAnnotation
    
    body fcn getAnnotation(annotationType: cheat addressint): unchecked ^Annotation
        result getDeclaredAnnotation(annotationType)
    end getAnnotation
    
    body fcn getDeclaredAnnotations(annotationType: cheat addressint): unchecked ^RepeatedAnnotation
        var resultAnnotations: ^MutableRepeatedAnnotation; new resultAnnotations;
        for i: 1..getDeclaredAnnotationCount()
            const lookup := annotations -> getAnnotation(i)
            if (lookup -> isInstance(annotationType)) then
                resultAnnotations -> addAnnotation(lookup)
            end if
        end for
        result resultAnnotations
    end getDeclaredAnnotations
    
    body fcn getAnnotations(annotationType: cheat addressint): unchecked ^RepeatedAnnotation
        result getDeclaredAnnotations(annotationType)
    end getAnnotations
    
end DeclaredTField