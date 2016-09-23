unit
class DeclaredTField
    inherit TField in "%oot/reflect/TField.tu"
    export construct
    
    var fieldOffset: nat
    
    proc construct(__fieldOffset: nat)
        fieldOffset := __fieldOffset
    end construct
    
    body fcn fetch(instance: unchecked ^anyclass): addressint
        result #instance + fieldOffset
    end fetch

    body fcn getAnnotations(): unchecked ^AnnotatedElement
        
    end getAnnotations
    
end DeclaredTField