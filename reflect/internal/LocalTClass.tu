unit
class LocalTClass
    inherit TClass in "%oot/reflect/TClass.tu"
    import Opcodes in "%oot/reflect/Opcodes.tu",
        DefinedOpInspector in "util/DefinedOpInspector.tu",
        ClassFactory in "%oot/reflect/internal/util/ClassFactory.tu",
        CodeHelper in "%oot/reflect/internal/util/CodeHelper.tu",
        ClassTFunction in "%oot/reflect/internal/ClassTFunction.tu",
        ReflectionFactory in "util/ReflectionFactory.tu",
        Conditions in "%oot/turing/util/Conditions.tu"
    export construct
    
    var factory: unchecked ^TFunction := nil
    
    var name: unchecked ^string := nil
    
    var descriptor: TYPE
    
    var context: unchecked ^ClassContext
    
    var functionCount: nat
    
    var declaredFunctions: flexible array 1..0 of unchecked ^TFunction
    
    var functionDeclarationSites: flexible array 1..0 of addressint
    
    proc construct(classDescriptor: TYPE, classContext: unchecked ^ClassContext)
        descriptor := classDescriptor
        context := classContext
    end construct
    
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
        var resultClass: ^LocalTClass
        var desc := TClass.TYPE @ (descriptor.expandClass)
        new resultClass; resultClass -> construct(desc, ReflectionFactory.makeClassContext(desc.initRoutine))
        result resultClass
    end getSuperclass
    
    body fcn inspect(): unchecked ^OpInspector
        var resultInspector: ^DefinedOpInspector
        new resultInspector; resultInspector -> construct(descriptor.initRoutine, context -> getEndAddress());
        result resultInspector
    end inspect
    
    body fcn getFunctionCount(): nat
        if (~Conditions.hasNat(functionCount)) then
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
            functionCount := upper(functionDeclarationSites)
        end if
        result functionCount
    end getFunctionCount
    
    body fcn getFunction(fcnNumber: nat): unchecked ^TFunction
        if (~Conditions.hasNat(functionCount)) then
            const count := getFunctionCount()
            new declaredFunctions, count
            
            for i: 1..count
                declaredFunctions(i) := nil
            end for
        end if
        
        if (fcnNumber > functionCount) then
            Error.Halt("Tried to access function #" + natstr(fcnNumber)
                + "in class " + getName() + ",  but " + getName()
                + " only has " + natstr(functionCount) + " functions")
        elsif (fcnNumber = 0) then
            Error.Halt("Class function access is one-indexed, function 0 cannot be accessed")
        end if
        
        if (~Conditions.isValid(declaredFunctions(fcnNumber))) then
            var resultFunc: ^ClassTFunction
            new resultFunc; resultFunc -> construct(ReflectionFactory.makeFunctionContext(functionDeclarationSites(fcnNumber), true));
            declaredFunctions(fcnNumber) := resultFunc
        end if
        
        result declaredFunctions(fcnNumber)
    end getFunction
    
    body fcn getDescriptor(): TYPE
        result descriptor
    end getDescriptor
    
    body fcn equals(o: ^Object): boolean
        if (objectclass(o) ~= objectclass(self)) then
            result false
        end if
        if (LocalTClass(o).getDescriptor().baseClass = descriptor.baseClass) then
            result true
        else
            result false
        end if
    end equals
    
end LocalTClass