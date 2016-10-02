unit
class Annotation
    inherit AnyRef in "%oot/reflect/AnyRef.tu"
    export getElementCount, getElement, isInstance
    
    deferred fcn getElementCount(): nat
    
    deferred fcn getElement(position: nat): addressint
    
    deferred fcn isInstance(annotationType: cheat addressint): boolean
end Annotation