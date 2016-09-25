unit
module AnnotationFactory
    import AnnotationManifest in "AnnotationManifest.tu",
        TFunction in "%oot/reflect/TFunction.tu",
        TField in "%oot/reflect/TField.tu",
        TClass in "%oot/reflect/TClass.tu",
        MemberAnnotationManifest in "MemberAnnotationManifest.tu",
        ContainerAnnotationManifest in "ContainerAnnotationManifest.tu",
        Opcodes in "%oot/reflect/Opcodes.tu"
    export getFunctionAnnotations, getFieldAnnotations, getClassAnnotations
    
    fcn getFunctionAnnotations(func: unchecked ^TFunction): unchecked ^AnnotationManifest
        var res: ^MemberAnnotationManifest
        new res; res -> construct(func -> getContext() -> getStartAddress());
        result res
    end getFunctionAnnotations
    
    fcn getFieldAnnotations(field: unchecked ^TField): unchecked ^AnnotationManifest
        var res: ^MemberAnnotationManifest
        new res; res -> construct(field -> getInitializer());
        result res
    end getFieldAnnotations
    
    fcn getClassAnnotations(clazz: unchecked ^TClass): unchecked ^AnnotationManifest
        var res: ^MemberAnnotationManifest
        new res; res -> construct(clazz -> getContext() -> getEndAddress() - Opcodes.OP_SIZE * 11);
        result res
    end getClassAnnotations
    
end AnnotationFactory