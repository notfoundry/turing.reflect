unit
module Source
    export ~.SourcePosition
    type SourcePosition:
        record
            lineNo: nat2
            fileNo: nat4
            linePos: nat2
            tokLen: nat2
        end record
end Source