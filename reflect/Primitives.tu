unit
module Primitives
    export TYPE,
        INT, INT1, INT2, INT4,
        NAT, NAT1, NAT2, NAT4,
        STRING,
        CHECKED_PTR, UNCHECKED_PTR,
        REAL, REAL4, REAL8,
        NONSCALAR, VOID,
        sizeOf
    
    type TYPE: enum(
        INT, INT1, INT2, INT4,
        NAT, NAT1, NAT2, NAT4,
        STRING,
        CHECKED_PTR, UNCHECKED_PTR,
        REAL, REAL4, REAL8,
        NONSCALAR, VOID
    )
    
    const INT := TYPE.INT
    
    const INT1 := TYPE.INT1
    
    const INT2 := TYPE.INT2
    
    const INT4 := TYPE.INT4
    
    const NAT := TYPE.NAT
    
    const NAT1 := TYPE.NAT1
    
    const NAT2 := TYPE.NAT2
    
    const NAT4 := TYPE.NAT4

    const STRING := TYPE.STRING

    const CHECKED_PTR := TYPE.CHECKED_PTR
    
    const UNCHECKED_PTR := TYPE.UNCHECKED_PTR
    
    const REAL := TYPE.REAL
    
    const REAL4 := TYPE.REAL4
    
    const REAL8 := TYPE.REAL8
    
    const NONSCALAR := TYPE.NONSCALAR
    
    const VOID := TYPE.VOID
    
    fcn sizeOf(primitiveType: TYPE): nat
        type Checked_Ptr: ^anyclass
        type Unchecked_Ptr: unchecked ^anyclass
        
        case (primitiveType) of
            label TYPE.INT: result sizeof(int)
            label TYPE.INT1: result sizeof(int1)
            label TYPE.INT2: result sizeof(int2)
            label TYPE.INT4: result sizeof(int4)
            label TYPE.NAT: result sizeof(nat)
            label TYPE.NAT1: result sizeof(nat1)
            label TYPE.NAT2: result sizeof(nat2)
            label TYPE.NAT4: result sizeof(nat4)
            label TYPE.STRING: result sizeof(string)
            label TYPE.CHECKED_PTR: result sizeof(Checked_Ptr)
            label TYPE.UNCHECKED_PTR: result sizeof(Unchecked_Ptr)
            label TYPE.REAL: result sizeof(real)
            label TYPE.REAL4: result sizeof(real4)
            label TYPE.REAL8: result sizeof(real8)
            label TYPE.NONSCALAR: result 0
            label TYPE.VOID: result 0
        end case
    end sizeOf
end Primitives