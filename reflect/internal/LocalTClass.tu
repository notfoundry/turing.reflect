unit
class LocalTClass
    inherit TClass in "%oot/reflect/TClass.tu"
    import Opcodes in "%oot/reflect/Opcodes.tu", ClassFactory in "%oot/reflect/internal/util/ClassFactory.tu",
        CodeHelper in "%oot/reflect/internal/util/CodeHelper.tu", ClassTFunction in "%oot/reflect/internal/ClassTFunction.tu", ReflectionFactory in "util/ReflectionFactory.tu"
    export construct
    
    var factory: unchecked ^TFunction := nil
    var name: unchecked ^string := nil
    var descriptor: TYPE
    var context: unchecked ^ClassContext
    
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
        factory -> invoke(addr(res))
        result res
    end newInstance
    
    body fcn getSuperclass(): unchecked ^TClass
        var resultClass: ^LocalTClass
        var desc := TClass.TYPE @ (descriptor.expandClass)
        new resultClass; resultClass -> construct(desc, ReflectionFactory.makeClassContext(desc.initRoutine))
        result resultClass
    end getSuperclass
    
    body fcn inspect(): unchecked ^OpInspector
        type __anyclass: unchecked ^anyclass
        var resultInspector: ^OpInspector
        new resultInspector; resultInspector -> construct(descriptor.initRoutine, context -> getEndAddress());
        result resultInspector
    end inspect
    
    body fcn getFunction(procNumber: nat): unchecked ^TFunction
        var it := inspect()
        var procCount := 0
        var op := it -> next()
        loop
            exit when ~it -> hasNext()
            op := it -> next()
            if (^op = Opcodes.PROC) then procCount += 1
            end if
            if (procCount = procNumber) then
                var resultFunc: ^ClassTFunction
                new resultFunc; resultFunc -> construct(ReflectionFactory.makeFunctionContext(#op, true));
                result resultFunc
            end if
        end loop
        result nil
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