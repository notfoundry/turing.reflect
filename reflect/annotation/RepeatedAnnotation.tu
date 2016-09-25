unit
class RepeatedAnnotation
    inherit Object in "%oot/turing/lang/Object.tu"
    import Annotation in "Annotation.tu"
    export getInstanceCount, getInstance

    deferred fcn getInstanceCount(): nat
    
    deferred fcn getInstance(position: nat): unchecked ^Annotation
    
end RepeatedAnnotation