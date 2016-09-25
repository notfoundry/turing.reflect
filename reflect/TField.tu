unit
class TField
    inherit AnnotatedElement in "annotation/AnnotatedElement.tu"
    import Primitives in "Primitives.tu"
    export fetch, getInitializer, getType
    
    deferred fcn fetch(instance: unchecked ^anyclass): addressint
    
    deferred fcn getInitializer(): addressint
    
    deferred fcn getType(): Primitives.TYPE
    
end TField