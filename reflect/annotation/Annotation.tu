unit
class Annotation
    inherit Object in "%oot/turing/lang/Object.tu"
    export getElementCount, getElement, isInstance
    
    deferred fcn getElementCount(): nat
    
    deferred fcn getElement(position: nat): addressint
    
    deferred fcn isInstance(annotationType: cheat addressint): boolean
end Annotation