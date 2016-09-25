unit
module FieldSupport
    import Opcodes in "%oot/reflect/Opcodes.tu",
        TClass in "%oot/reflect/TClass.tu",
        FieldManifest in "FieldManifest.tu",
        DeclaredFieldManifest in "DeclaredFieldManifest.tu",
        OpcodeHelper in "%oot/reflect/internal/util/OpcodeHelper.tu",
        TField in "%oot/reflect/TField.tu",
        DeclaredTField in "%oot/reflect/internal/DeclaredTField.tu",
        Primitives in "%oot/reflect/Primitives.tu"
    export getDeclaredFields
    
    fcn createField(fieldOffset: nat, fieldType: Primitives.TYPE, initializer: addressint): unchecked ^TField
        var resultField: ^DeclaredTField
        new resultField; resultField -> construct(fieldOffset, fieldType, initializer);
        result resultField
    end createField
    
    fcn getDeclaredFields(clazz: unchecked ^TClass): unchecked ^FieldManifest
        const context := clazz -> getContext()
        var op := context -> getStartAddress()
        var fields: ^DeclaredFieldManifest; new fields;
        loop
            exit when op > context -> getEndAddress()
            case (Opcodes.TYPE @ (op)) of
                label JUMP: op += Opcodes.TYPE @ (op + Opcodes.OP_SIZE)
                label LOCATECLASS:
                    if (Opcodes.TYPE @ (op + Opcodes.OP_SIZE) >= 4) then
                        const fieldOffset := Opcodes.TYPE @ (op + Opcodes.OP_SIZE)
                        op += Opcodes.OP_SIZE * 2
                        const opLookup := Opcodes.TYPE @ (op)
                        if (OpcodeHelper.isInitializationOp(opLookup)) then
                            fields -> addField(createField(fieldOffset, OpcodeHelper.returnTypeFromInitializationOp(opLookup), op))
                        elsif (OpcodeHelper.isDereferencingOp(opLookup)) then
                            fields -> addField(createField(fieldOffset, OpcodeHelper.returnTypeFromMergeOp(opLookup), op))
                        elsif (opLookup = PUSHADDR1) then
                            op += Opcodes.OP_SIZE * 3
                            if (OpcodeHelper.isInitializationOp(Opcodes.TYPE @ (op))) then
                                fields -> addField(createField(fieldOffset, OpcodeHelper.returnTypeFromInitializationOp(Opcodes.TYPE @ (op)), op))
                            end if
                        elsif (opLookup = INITARRAYDESC) then
                            fields -> addField(createField(fieldOffset, Primitives.FLEXIBLE_ARRAY, op))
                        end if
                    end if
                    op += Opcodes.OP_SIZE 
                label: op += Opcodes.OP_SIZE 
            end case
        end loop
        result fields
    end getDeclaredFields
    
end FieldSupport