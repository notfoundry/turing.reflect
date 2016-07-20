unit
class ClassTFunction
    inherit LocalTFunction in "LocalTFunction.tu"
    
    body proc invoke(returnAddr: addressint)
        type __procedure: proc x()
        var it := inspect()
        var tmp: array 1..it -> count() of nat
        var ind := 1
        loop
            exit when ~it -> hasNext()
            var op := it -> next()
            if (^op = Opcodes.LOCATEPARM & nat @ (#op+4) = 4) then
                tmp(ind) := Opcodes.PUSHADDR;
                tmp(ind+1) := returnAddr;
                ind += 2
                for i: 1..2
                    op := it -> next()
                end for
            else
                tmp(ind) := ^op
                ind += 1
            end if
        end loop
        cheat(__procedure, addr(tmp))()
    end invoke
    
end ClassTFunction