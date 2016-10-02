unit
class *AnyRef
    export equals
    
    deferred fcn equals(o: unchecked ^anyclass): boolean
    body fcn equals(o: unchecked ^anyclass): boolean
        result self = o
    end equals
    
end AnyRef