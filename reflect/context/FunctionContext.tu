unit
class FunctionContext
    inherit AbstractContext in "AbstractContext.tu"
    export construct, isFunction, isInClass, getStackSize
    
    var isFunc, inClass: boolean
    var stackSize: nat
    
    proc construct(__startAddress, __endAddress: addressint,
            __isFunc, __inClass: boolean,
            __sourceLength, __stackSize, __opCount: nat)
        
        startAddress := __startAddress
        endAddress := __endAddress
        isFunc := __isFunc
        inClass := __inClass
        sourceLength := __sourceLength
        stackSize := __stackSize
        opCount := __opCount
    end construct
    
    fcn isFunction(): boolean
        result isFunc
    end isFunction
    
    fcn isInClass(): boolean
        result inClass
    end isInClass
    
    fcn getStackSize(): nat
        result stackSize
    end getStackSize
    
end FunctionContext