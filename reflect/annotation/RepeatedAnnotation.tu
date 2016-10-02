unit
class RepeatedAnnotation
    inherit AnyRef in "%oot/reflect/AnyRef.tu"
    import Annotation in "Annotation.tu"
    export getInstanceCount, getInstance

    deferred fcn getInstanceCount(): nat
    
    deferred fcn getInstance(position: nat): unchecked ^Annotation
    
end RepeatedAnnotation