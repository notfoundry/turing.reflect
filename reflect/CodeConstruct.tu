unit
class CodeConstruct
    inherit Object in "%oot/turing/lang/Object.tu"
    import OpInspector in "util/OpInspector.tu"
    export inspect
    
    deferred fcn inspect(): unchecked ^OpInspector
end CodeConstruct