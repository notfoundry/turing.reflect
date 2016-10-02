unit
class FieldManifest
    inherit AnyRef in "%oot/reflect/AnyRef.tu"
    import TField in "%oot/reflect/TField.tu"
    export getField, getFieldCount
    
    deferred fcn getField(fieldNumber: nat): unchecked ^TField
    
    deferred fcn getFieldCount(): nat
    
end FieldManifest