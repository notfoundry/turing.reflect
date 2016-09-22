unit
class FunctionContext
    inherit CodeContext in "CodeContext.tu"
    export isFunction, isInClass, getStackSize
    
    deferred fcn isFunction(): boolean
    
    deferred fcn isInClass(): boolean
    
    deferred fcn getStackSize(): nat
    
end FunctionContext