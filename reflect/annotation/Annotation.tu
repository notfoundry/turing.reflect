unit
class Annotation
    inherit Object in "%oot/turing/lang/Object.tu"
    export getElementCount, getElement
    
    deferred fcn getElementCount(): nat
    
    deferred fcn getElement(position: nat): addressint
end Annotation