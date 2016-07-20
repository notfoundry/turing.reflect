unit
module *Universe
    import TClass in "TClass.tu", LocalTClass in "internal/LocalTClass.tu",
        TFunction in "TFunction.tu", LocalTFunction in "internal/LocalTFunction.tu",
        Opcodes in "Opcodes.tu", ReflectionFactory in "internal/util/ReflectionFactory.tu"
    export reflectc, reflectf
    
    
    fcn reflectc(o: cheat addressint): unchecked ^TClass
        type __anyclass: unchecked ^anyclass
        var resultClass: ^LocalTClass
        var descriptor := cheat(TClass.TYPE, objectclass(cheat(__anyclass, o)))
        new resultClass; resultClass -> construct(descriptor, ReflectionFactory.makeClassContext(descriptor.initRoutine));
        result resultClass
    end reflectc
    
    fcn reflectf(o: cheat addressint): unchecked ^TFunction
        var resultFunc: ^LocalTFunction
        new resultFunc; resultFunc -> construct(ReflectionFactory.makeFunctionContext(o, false));
        result resultFunc
    end reflectf
end Universe