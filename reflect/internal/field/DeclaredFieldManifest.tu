unit
class DeclaredFieldManifest
    inherit FieldManifest in "%oot/reflect/internal/field/FieldManifest.tu"
    export addField
    
    var fields: flexible array 1..0 of unchecked ^TField
    
    body fcn getField(fieldNumber: nat): unchecked ^TField
        result fields(fieldNumber)
    end getField
    
    body fcn getFieldCount(): nat
        result upper(fields)
    end getFieldCount
    
    proc addField(field: unchecked ^TField)
        new fields, upper(fields)+1
        fields(upper(fields)) := field
    end addField
    
end DeclaredFieldManifest