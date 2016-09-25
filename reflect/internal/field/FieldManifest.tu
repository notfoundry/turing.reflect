unit
class FieldManifest
    inherit Object in "%oot/turing/lang/Object.tu"
    import TField in "%oot/reflect/TField.tu"
    export getField, getFieldCount
    
    deferred fcn getField(fieldNumber: nat): unchecked ^TField
    
    deferred fcn getFieldCount(): nat
    
end FieldManifest