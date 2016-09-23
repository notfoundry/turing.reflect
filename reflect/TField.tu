unit
class TField
    inherit Object in "%oot/turing/lang/Object.tu"
    import AnnotatedElement in "annotation/AnnotatedElement.tu"
    export fetch, getAnnotations
    
    deferred fcn fetch(instance: unchecked ^anyclass): addressint

    deferred fcn getAnnotations(): unchecked ^AnnotatedElement
    
end TField