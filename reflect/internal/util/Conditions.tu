unit
module Conditions
    export hasString, hasInt, hasNat, hasReal, hasBoolean, isValid
    
    const FREED_MEMORY_MARKER := 3722304989
    
    fcn hasString(var stringField: string): boolean
        result nat1 @ (addr(stringField)) ~= 128 & nat1 @ (addr(stringField)+1) = 0
    end hasString
    
    fcn hasInt(var intField: int): boolean
        result int4 @ (addr(intField)) >= minint
    end hasInt
    
    fcn hasNat(var natField: nat): boolean
        result maxnat >= nat4 @ (addr(natField))
    end hasNat
    
    fcn hasReal(var realField: real): boolean
        result nat1 @ (addr(realField)+3) ~= 128 & nat1 @ (addr(realField)+7) ~= 128
    end hasReal
    
    fcn hasBoolean(var booleanField: boolean): boolean
        result int1 @ (addr(booleanField)) >= 0
    end hasBoolean
    
    fcn isValid(classPointer: unchecked ^anyclass): boolean
        %   normally the first 4 bytes of a class pointer would be a reference to the pointer class type
        result classPointer ~= nil & nat4 @ (#classPointer) ~= FREED_MEMORY_MARKER
    end isValid
end Conditions