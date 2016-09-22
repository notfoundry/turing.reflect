unit
class DeclaredFunctionContext
    inherit FunctionContext in "%oot/reflect/context/FunctionContext.tu"
    export construct
    
    var isFunc, inClass: boolean
    
    var stackSize: nat
    
    var startAddress, endAddress: addressint
    
    var sourceLength, opCount: nat
    
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
    
    body fcn isFunction(): boolean
        result isFunc
    end isFunction
    
    body fcn isInClass(): boolean
        result inClass
    end isInClass
    
    body fcn getStackSize(): nat
        result stackSize
    end getStackSize
    
end DeclaredFunctionContext