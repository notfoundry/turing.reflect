unit
module ReflectiveObjects
    import TClass in "%oot/reflect/TClass.tu",
        LocalTClass in "%oot/reflect/internal/LocalTClass.tu",
        ProxyTClass in "%oot/reflect/internal/ProxyTClass.tu",
        TFunction in "%oot/reflect/TFunction.tu",
        LocalTFunction in "%oot/reflect/internal/LocalTFunction.tu",
        ProxyTFunction in "%oot/reflect/internal/ProxyTFunction.tu",
        ContextFactory in "%oot/reflect/internal/util/ContextFactory.tu",
        Conditions in "Conditions.tu"
    export getClass, getFunction
    
    type CachedClass:
        record
            rawClass: unchecked ^TClass
            wrappedClass: unchecked ^TClass
        end record
    
    type CachedFunction:
        record
            rawFunction: unchecked ^TFunction
            wrappedFunction: unchecked ^TFunction
        end record
    
    var cachedClasses: flexible array 1..0 of CachedClass
    
    var cachedFunctions: flexible array 1..0 of CachedFunction
    
    fcn wrapClass(clazz: unchecked ^TClass): unchecked ^TClass
        var classWrapper: ^ProxyTClass
        new classWrapper; classWrapper -> construct(clazz);
        result classWrapper
    end wrapClass
    
    fcn wrapFunction(func: unchecked ^TFunction): unchecked ^TFunction
        var functionWrapper: ^ProxyTFunction
        new functionWrapper; functionWrapper -> construct(func);
        result functionWrapper
    end wrapFunction
    
    fcn getClass(classDescriptor: TClass.TYPE): unchecked ^TClass
        for i: 1..upper(cachedClasses)
            if (cachedClasses(i).rawClass -> getDescriptor().baseClass = classDescriptor.baseClass) then
                if (~Conditions.isValid(cachedClasses(i).wrappedClass)) then
                    cachedClasses(i).wrappedClass := wrapClass(cachedClasses(i).rawClass)
                end if
                result cachedClasses(i).wrappedClass
            end if
        end for
        
        var rawClass: ^LocalTClass
        new rawClass; rawClass -> construct(classDescriptor, ContextFactory.makeClassContext(classDescriptor.initRoutine));
        
        new cachedClasses, upper(cachedClasses) + 1
        
        const workingAddr := addr(cachedClasses(upper(cachedClasses)))
        CachedClass @ (workingAddr).rawClass := rawClass
        CachedClass @ (workingAddr).wrappedClass := wrapClass(rawClass)

        result CachedClass @ (workingAddr).wrappedClass
    end getClass
    
    fcn getFunction(functionPointer: addressint): unchecked ^TFunction
        
        for i: 1..upper(cachedFunctions)
            if (cachedFunctions(i).rawFunction -> getContext() -> getStartAddress() = functionPointer) then
                if (~Conditions.isValid(cachedFunctions(i).wrappedFunction)) then
                    cachedFunctions(i).wrappedFunction := wrapFunction(cachedFunctions(i).rawFunction)
                end if
                result cachedFunctions(i).wrappedFunction
            end if
        end for
        
        var rawFunction: ^LocalTFunction
        new rawFunction; rawFunction -> construct(ContextFactory.makeFunctionContext(functionPointer, false));
        
        new cachedFunctions, upper(cachedFunctions) + 1
        
        const workingAddr := addr(cachedFunctions(upper(cachedFunctions)))
        CachedFunction @ (workingAddr).rawFunction := rawFunction
        CachedFunction @ (workingAddr).wrappedFunction := wrapFunction(rawFunction)

        result CachedFunction @ (workingAddr).wrappedFunction
    end getFunction
    
end ReflectiveObjects