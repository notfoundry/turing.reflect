unit
class MutableRepeatedAnnotation
    inherit RepeatedAnnotation in "%oot/reflect/annotation/RepeatedAnnotation.tu"
    export addAnnotation
    
    var annotations: flexible array 1..0 of unchecked ^Annotation
    
    body fcn getInstanceCount(): nat
        result upper(annotations)
    end getInstanceCount
    
    body fcn getInstance(position: nat): unchecked ^Annotation
        result annotations(position)
    end getInstance
    
    proc addAnnotation(annotation: unchecked ^Annotation)
        new annotations, upper(annotations)+1
        annotations(upper(annotations)) := annotation
    end addAnnotation
    
end MutableRepeatedAnnotation