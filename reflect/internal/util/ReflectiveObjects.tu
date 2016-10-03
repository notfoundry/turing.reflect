unit
module ReflectiveObjects
    import TClass in "%oot/reflect/TClass.tu",
        LocalTClass in "%oot/reflect/internal/LocalTClass.tu",
        ProxyTClass in "%oot/reflect/internal/ProxyTClass.tu",
        TFunction in "%oot/reflect/TFunction.tu",
        LocalTFunction in "%oot/reflect/internal/LocalTFunction.tu",
        ProxyTFunction in "%oot/reflect/internal/ProxyTFunction.tu",
        ContextFactory in "%oot/reflect/internal/util/ContextFactory.tu"
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
    
    fcn getClass(classDescriptor: TClass.TYPE): unchecked ^TClass
        var resultClass: ^LocalTClass
        new resultClass; resultClass -> construct(classDescriptor, ContextFactory.makeClassContext(classDescriptor.initRoutine));
        
        var classWrapper: ^ProxyTClass
        new classWrapper; classWrapper -> construct(resultClass);
        
        result classWrapper
    end getClass
    
    fcn getFunction(functionPointer: addressint): unchecked ^TFunction
        var resultFunction: ^LocalTFunction
        new resultFunction; resultFunction -> construct(ContextFactory.makeFunctionContext(functionPointer, false));
        
        var functionWrapper: ^ProxyTFunction
        new functionWrapper; functionWrapper -> construct(resultFunction);
        
        result functionWrapper
    end getFunction
    
end ReflectiveObjects