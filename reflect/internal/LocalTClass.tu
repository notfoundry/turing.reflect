unit
class LocalTClass
    inherit TClass in "%oot/reflect/TClass.tu"
    import Opcodes in "%oot/reflect/Opcodes.tu",
        DefinedOpInspector in "util/DefinedOpInspector.tu",
        ClassFactory in "%oot/reflect/internal/util/ClassFactory.tu",
        CodeHelper in "%oot/reflect/internal/util/CodeHelper.tu",
        ClassTFunction in "%oot/reflect/internal/ClassTFunction.tu",
        ReflectionFactory in "util/ReflectionFactory.tu",
        Conditions in "%oot/turing/util/Conditions.tu",
        FieldSupport in "field/FieldSupport.tu",
        FieldManifest in "field/FieldManifest.tu",
        AnnotationManifest in "annotation/AnnotationManifest.tu",
        AnnotationFactory in "annotation/AnnotationFactory.tu",
        MutableRepeatedAnnotation in "annotation/MutableRepeatedAnnotation.tu"
    export construct
    
    const NONEXISTENT_CLASS := 0
    
    var factory: unchecked ^TFunction := nil
    
    var name: unchecked ^string := nil
    
    var descriptor: TYPE
    
    var context: unchecked ^ClassContext
    
    var superclass: unchecked ^TClass := nil
    
    var fields: unchecked ^FieldManifest := nil
    
    var annotations: unchecked ^AnnotationManifest := nil
    
    var declaredFunctionCount: nat
    
    var declaredFunctions: flexible array 1..0 of unchecked ^TFunction
    
    var functionDeclarationSites: flexible array 1..0 of addressint
    
    proc construct(classDescriptor: TYPE, classContext: unchecked ^ClassContext)
        descriptor := classDescriptor
        context := classContext
    end construct
    
    body fcn inspect(): unchecked ^OpInspector
        var resultInspector: ^DefinedOpInspector
        new resultInspector; resultInspector -> construct(descriptor.initRoutine, context -> getEndAddress());
        result resultInspector
    end inspect
    
    body fcn getName(): string
        if (name = nil) then
            var address := descriptor.baseClass - 1
            loop
                exit when char @ (address) ~= '\0'
                address -= 1
            end loop
            loop
                exit when char @ (address-1) = '\0' | nat1 @ (address-1) = 253
                address -= 1
            end loop
            #name := address
        end if
        result ^name
    end getName
    
    body fcn newInstance(): unchecked ^anyclass
        if (factory = nil) then
            factory := ClassFactory.makeFactory(descriptor.baseClass)
        end if
        var res: unchecked ^anyclass
        factory -> invoke(addr(res), nil)
        result res
    end newInstance
    
    body fcn getSuperclass(): unchecked ^TClass
        if (superclass = nil) then
            if (descriptor.expandClass ~= NONEXISTENT_CLASS) then
                var resultClass: ^LocalTClass
                var desc := TClass.TYPE @ (descriptor.expandClass)
                new resultClass; resultClass -> construct(desc, ReflectionFactory.makeClassContext(desc.initRoutine))
                superclass := resultClass
            else
                superclass := nil
            end if
        end if
        result superclass
    end getSuperclass
    
    body fcn getDescriptor(): TYPE
        result descriptor
    end getDescriptor
    
    body fcn getContext(): unchecked ^ClassContext
        result context
    end getContext
    
    body fcn getDeclaredFunctionCount(): nat
        if (~Conditions.hasNat(declaredFunctionCount)) then
            var it := inspect()
            %   advance by one opcode here to prevent the synthetic initialization procedure from being counted
            var op := it -> next()
            loop
                exit when ~it -> hasNext()
                op := it -> next()
                if (^op = Opcodes.PROC) then
                    new functionDeclarationSites, upper(functionDeclarationSites)+1
                    functionDeclarationSites(upper(functionDeclarationSites)) := #op
                end if
            end loop
            declaredFunctionCount := upper(functionDeclarationSites)
        end if
        result declaredFunctionCount
    end getDeclaredFunctionCount
    
    body fcn getDeclaredFunction(fcnNumber: nat): unchecked ^TFunction
        const count := getDeclaredFunctionCount()
        
        if (upper(declaredFunctions) ~= declaredFunctionCount) then
            new declaredFunctions, declaredFunctionCount
            for i: 1..count
                declaredFunctions(i) := nil
            end for
        end if
        
        if (fcnNumber > declaredFunctionCount) then
            Error.Halt("Tried to access function #" + natstr(fcnNumber)
                + " in class " + getName() + ",  but " + getName()
                + " only has " + natstr(declaredFunctionCount) + " functions")
        elsif (fcnNumber = 0) then
            Error.Halt("Class function access is one-indexed, function 0 cannot be accessed")
        end if

        if (~Conditions.isValid(declaredFunctions(fcnNumber))) then
            var resultFunc: ^ClassTFunction
            new resultFunc; resultFunc -> construct(ReflectionFactory.makeFunctionContext(functionDeclarationSites(fcnNumber), true));
            declaredFunctions(fcnNumber) := resultFunc
        end if
        
        result declaredFunctions(fcnNumber)
    end getDeclaredFunction
    
    body fcn getFunctionCount(): nat
        var clazz := getSuperclass()
        var functionCount := getDeclaredFunctionCount()
        loop
            exit when clazz = nil
            functionCount += clazz -> getDeclaredFunctionCount()
            clazz := clazz -> getSuperclass()
        end loop
        result functionCount
    end getFunctionCount
    
    body fcn getFunction(fcnNumber: nat): unchecked ^TFunction
        const parent := getSuperclass()
        const parentCount := parent -> getFunctionCount()
        if (fcnNumber > parentCount) then
            result getDeclaredFunction(fcnNumber - parentCount)
        else
            result parent -> getFunction(fcnNumber)
        end if
    end getFunction
    
    body fcn getDeclaredFieldCount(): nat
        if (fields = nil) then
            fields := FieldSupport.getDeclaredFields(self)
        end if
        result fields -> getFieldCount()
    end getDeclaredFieldCount
    
    body fcn getDeclaredField(fieldNumber: nat): unchecked ^TField
        const count := getDeclaredFieldCount()
        if (fieldNumber > count) then
            Error.Halt("Tried to access field #" + natstr(fieldNumber)
                + " in class " + getName() + ",  but " + getName()
                + " only has " + natstr(count) + " fields")
        elsif (fieldNumber = 0) then
            Error.Halt("Class field access is one-indexed, field 0 cannot be accessed")
        end if
        
        result fields -> getField(fieldNumber)
    end getDeclaredField
    
    body fcn getFieldCount(): nat
        var clazz := getSuperclass()
        var fieldCount := getDeclaredFieldCount()
        loop
            exit when clazz = nil
            fieldCount += clazz -> getDeclaredFieldCount()
            clazz := clazz -> getSuperclass()
        end loop
        result fieldCount
    end getFieldCount
    
    body fcn getField(fieldNumber: nat): unchecked ^TField
        const parent := getSuperclass()
        const parentCount := parent -> getFieldCount()
        if (fieldNumber > parentCount) then
            result getDeclaredField(fieldNumber - parentCount)
        else
            result parent -> getField(fieldNumber)
        end if
    end getField
    
    body fcn getDeclaredAnnotationCount(): nat
        if (annotations = nil) then
            annotations := AnnotationFactory.getClassAnnotations(self)
        end if
        result annotations -> getAnnotationCount()
    end getDeclaredAnnotationCount
    
    body fcn getAnnotationCount(): nat
        var clazz := getSuperclass()
        var annotationCount := getDeclaredAnnotationCount()
        loop
            exit when clazz = nil
            annotationCount += clazz -> getDeclaredAnnotationCount()
            clazz := clazz -> getSuperclass()
        end loop
        result annotationCount
    end getAnnotationCount
    
    body fcn getDeclaredAnnotationAt(position: nat): unchecked ^Annotation
        const count := getDeclaredAnnotationCount()
        if (position > count) then
            Error.Halt("Tried to access annotation #" + natstr(position)
                + " in class " + getName() + ",  but " + getName()
                + " only has " + natstr(count) + " annotations")
        elsif (position = 0) then
            Error.Halt("Class annotation access is one-indexed, annotation 0 cannot be accessed")
        end if
        
        result annotations -> getAnnotation(position)
    end getDeclaredAnnotationAt
    
    body fcn getAnnotationAt(position: nat): unchecked ^Annotation
        const parent := getSuperclass()
        const parentCount := parent -> getAnnotationCount()
        if (position > parentCount) then
            result getDeclaredAnnotationAt(position - parentCount)
        else
            result parent -> getAnnotationAt(position)
        end if
    end getAnnotationAt

    body fcn getDeclaredAnnotation(annotationType: cheat addressint): unchecked ^Annotation
        for i: 1..getDeclaredAnnotationCount()
            const lookup := annotations -> getAnnotation(i)
            if (lookup -> isInstance(annotationType)) then
                result lookup
            end if
        end for
        result nil
    end getDeclaredAnnotation
    
    body fcn getAnnotation(annotationType: cheat addressint): unchecked ^Annotation
        var clazz := self
        loop
            exit when clazz = nil
            const lookup := clazz -> getDeclaredAnnotation(annotationType)
            if (lookup ~= nil) then
                result lookup
            else
                clazz := clazz -> getSuperclass()
            end if
        end loop
        result nil
    end getAnnotation
    
    body fcn getDeclaredAnnotations(annotationType: cheat addressint): unchecked ^RepeatedAnnotation
        var resultAnnotations: ^MutableRepeatedAnnotation; new resultAnnotations;
        for i: 1..getDeclaredAnnotationCount()
            const lookup := getDeclaredAnnotationAt(i)
            if (lookup -> isInstance(annotationType)) then
                resultAnnotations -> addAnnotation(lookup)
            end if
        end for
        result resultAnnotations
    end getDeclaredAnnotations

    body fcn getAnnotations(annotationType: cheat addressint): unchecked ^RepeatedAnnotation
        var resultAnnotations: ^MutableRepeatedAnnotation; new resultAnnotations;
        for i: 1..getAnnotationCount()
            const lookup := getAnnotationAt(i)
            if (lookup -> isInstance(annotationType)) then
                resultAnnotations -> addAnnotation(lookup)
            end if
        end for
        result resultAnnotations
    end getAnnotations
    
    body fcn isAssignableFrom(clazz: unchecked ^TClass): boolean
        const classLookup := getDescriptor().baseClass
        var currentClass := clazz
        loop
            exit when currentClass = nil
            if (currentClass -> getDescriptor().baseClass = classLookup) then
                result true
            end if
            currentClass := currentClass -> getSuperclass()
        end loop
        result false
    end isAssignableFrom
    
    body fcn isInstance(obj: unchecked ^anyclass): boolean
        const classLookup := getDescriptor().baseClass
        var currentClass := cheat(TYPE, objectclass(obj))
        loop
            exit when currentClass.baseClass = 0
            if (currentClass.baseClass = classLookup) then
                result true
            end if
            if (currentClass.expandClass = 0) then result false
            else currentClass := TYPE @ (currentClass.expandClass)
            end if
        end loop
        result false
    end isInstance
    
end LocalTClass