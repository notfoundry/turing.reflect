unit
module *Opcodes
    export ~.ABORT, ~.ABORTCOND, ~.ABSINT, ~.ABSREAL, ~.ADDINT, ~.ADDINTNAT, ~.ADDNAT, ~.ADDNATINT, ~.ADDREAL, ~.ADDSET, ~.ALLOCFLEXARRAY, ~.ALLOCGLOB, ~.ALLOCGLOBARRAY, ~.ALLOCLOC, ~.ALLOCLOCARRAY, ~.AND, ~.ARRAYUPPER, ~.ASNADDR, ~.ASNADDRINV, ~.ASNINT, ~.ASNINTINV, ~.ASNINT1, ~.ASNINT1INV, ~.ASNINT2, ~.ASNINT2INV, ~.ASNINT4, ~.ASNINT4INV, ~.ASNNAT, ~.ASNNATINV, ~.ASNNAT1, ~.ASNNAT1INV, ~.ASNNAT2, ~.ASNNAT2INV, ~.ASNNAT4, ~.ASNNAT4INV, ~.ASNNONSCALAR, ~.ASNNONSCALARINV, ~.ASNPTR, ~.ASNPTRINV, ~.ASNREAL, ~.ASNREALINV, ~.ASNREAL4, ~.ASNREAL4INV, ~.ASNREAL8, ~.ASNREAL8INV, ~.ASNSTR, ~.ASNSTRINV, ~.BEGINHANDLER, ~.BITSASSIGN, ~.BITSEXTRACT, ~.CALL, ~.CALLEXTERNAL, ~.CALLIMPLEMENTBY, ~.CASE, ~.CAT, ~.CHARSUBSTR1, ~.CHARSUBSTR2, ~.CHARTOCSTR, ~.CHARTOSTR, ~.CHARTOSTRLEFT, ~.CHKCHRSTRSIZE, ~.CHKCSTRRANGE, ~.CHKRANGE, ~.CHKSTRRANGE, ~.CHKSTRSIZE, ~.CLOSE, ~.COPYARRAYDESC, ~.CSTRTOCHAR, ~.CSTRTOSTR, ~.CSTRTOSTRLEFT, ~.DEALLOCFLEXARRAY, ~.DECSP, ~.DIVINT, ~.DIVNAT, ~.DIVREAL, ~.EMPTY, ~.ENDFOR, ~.EOF, ~.EQADDR, ~.EQCHARN, ~.EQINT, ~.EQINTNAT, ~.EQNAT, ~.EQREAL, ~.EQSET, ~.EQSTR, ~.EXPINTINT, ~.EXPREALINT, ~.EXPREALREAL, ~.FETCHADDR, ~.FETCHBOOL, ~.FETCHINT, ~.FETCHINT1, ~.FETCHINT2, ~.FETCHINT4, ~.FETCHNAT, ~.FETCHNAT1, ~.FETCHNAT2, ~.FETCHNAT4, ~.FETCHPTR, ~.FETCHREAL, ~.FETCHREAL4, ~.FETCHREAL8, ~.FETCHSET, ~.FETCHSTR, ~.FIELD, ~.FOR, ~.FORK, ~.FREE, ~.FREECLASS, ~.FREEU, ~.GECHARN, ~.GECLASS, ~.GEINT, ~.GEINTNAT, ~.GENAT, ~.GENATINT, ~.GEREAL, ~.GESET, ~.GESTR, ~.GET, ~.GETPRIORITY, ~.GTCLASS, ~.IF, ~.IN, ~.INCLINENO, ~.INCSP, ~.INFIXAND, ~.INFIXOR, ~.INITARRAYDESC, ~.INITCONDITION, ~.INITMONITOR, ~.INITUNIT, ~.INTREAL, ~.INTREALLEFT, ~.INTSTR, ~.JSR, ~.JUMP, ~.JUMPB, ~.LECHARN, ~.LECLASS, ~.LEINT, ~.LEINTNAT, ~.LENAT, ~.LENATINT, ~.LEREAL, ~.LESET, ~.LESTR, ~.LOCATEARG, ~.LOCATECLASS, ~.LOCATELOC, ~.LOCATEPARM, ~.LOCATETEMP, ~.LTCLASS, ~.MAXINT, ~.MAXNAT, ~.MAXREAL, ~.MININT, ~.MINNAT, ~.MINREAL, ~.MODINT, ~.MODNAT, ~.MODREAL, ~.MONITORENTER, ~.MONITOREXIT, ~.MULINT, ~.MULNAT, ~.MULREAL, ~.MULSET, ~.NATREAL, ~.NATREALLEFT, ~.NATSTR, ~.NEGINT, ~.NEGREAL, ~.NEW, ~.NEWARRAY, ~.NEWCLASS, ~.NEWU, ~.NOT, ~.NUMARRAYELEMENTS, ~.OBJCLASS, ~.OPEN, ~.OR, ~.ORD, ~.PAUSE, ~.PRED, ~.PROC, ~.PUSHADDR, ~.PUSHADDR1, ~.PUSHCOPY, ~.PUSHINT, ~.PUSHINT1, ~.PUSHINT2, ~.PUSHREAL, ~.PUSHVAL0, ~.PUSHVAL1, ~.PUT, ~.QUIT, ~.READ, ~.REALDIVIDE, ~.REMINT, ~.REMREAL, ~.RESOLVEDEF, ~.RESOLVEPTR, ~.RESTORESP, ~.RETURN, ~.RTS, ~.SAVESP, ~.SEEK, ~.SEEKSTAR, ~.SETALL, ~.SETCLR, ~.SETELEMENT, ~.SETFILENO, ~.SETLINENO, ~.SETPRIORITY, ~.SETSTDSTREAM, ~.SETSTREAM, ~.SHL, ~.SHR, ~.SIGNAL, ~.STRINT, ~.STRINTOK, ~.STRNAT, ~.STRNATOK, ~.STRTOCHAR, ~.SUBINT, ~.SUBINTNAT, ~.SUBNAT, ~.SUBNATINT, ~.SUBREAL, ~.SUBSCRIPT, ~.SUBSET, ~.SUBSTR1, ~.SUBSTR2, ~.SUCC, ~.TAG, ~.TELL, ~.UFIELD, ~.UNINIT, ~.UNINITADDR, ~.UNINITBOOLEAN, ~.UNINITINT, ~.UNINITNAT, ~.UNINITREAL, ~.UNINITSTR, ~.UNLINKHANDLER, ~.VSUBSCRIPT, ~.WAIT, ~.WRITE, ~.XOR, ~.XORSET, ~.BREAK, ~.SYSEXIT, ~.ILLEGAL,
    TYPE, OP_SIZE, argCount, nameOf, MAX_OP, MIN_OP, MAX_OPERAND_COUNT
    
    type TYPE: nat4
    
    const OP_SIZE: nat1 := 4
    
    const MAX_OP: nat1 := 254
    
    const MIN_OP: nat1 := 0
    
    const MAX_OPERAND_COUNT := 4
    
    const ABORT: nat1 := 0
    const ABORTCOND: nat1 := 1
    const ABSINT: nat1 := 2
    const ABSREAL: nat1 := 3
    const ADDINT: nat1 := 4
    const ADDINTNAT: nat1 := 5
    const ADDNAT: nat1 := 6
    const ADDNATINT: nat1 := 7
    const ADDREAL: nat1 := 8
    const ADDSET: nat1 := 9
    
    const ALLOCFLEXARRAY: nat1 := 10
    const ALLOCGLOB: nat1 := 11
    const ALLOCGLOBARRAY: nat1 := 12
    const ALLOCLOC: nat1 := 13
    const ALLOCLOCARRAY: nat1 := 14
    const AND: nat1 := 15
    const ARRAYUPPER: nat1 := 16
    const ASNADDR: nat1 := 17
    const ASNADDRINV: nat1 := 18
    const ASNINT: nat1 := 19
    
    const ASNINTINV: nat1 := 20
    const ASNINT1: nat1 := 21
    const ASNINT1INV: nat1 := 22
    const ASNINT2: nat1 := 23
    const ASNINT2INV: nat1 := 24
    const ASNINT4: nat1 := 25
    const ASNINT4INV: nat1 := 26
    const ASNNAT: nat1 := 27
    const ASNNATINV: nat1 := 28
    const ASNNAT1: nat1 := 29
    
    const ASNNAT1INV: nat1 := 30
    const ASNNAT2: nat1 := 31
    const ASNNAT2INV: nat1 := 32
    const ASNNAT4: nat1 := 33
    const ASNNAT4INV: nat1 := 34
    const ASNNONSCALAR: nat1 := 35
    const ASNNONSCALARINV: nat1 := 36
    const ASNPTR: nat1 := 37
    const ASNPTRINV: nat1 := 38
    const ASNREAL: nat1 := 39
    
    const ASNREALINV: nat1 := 40
    const ASNREAL4: nat1 := 41
    const ASNREAL4INV: nat1 := 42
    const ASNREAL8: nat1 := 43
    const ASNREAL8INV: nat1 := 44
    const ASNSTR: nat1 := 45
    const ASNSTRINV: nat1 := 46
    const BEGINHANDLER: nat1 := 47
    const BITSASSIGN: nat1 := 48
    const BITSEXTRACT: nat1 := 49
    
    const CALL: nat1 := 50
    const CALLEXTERNAL: nat1 := 51
    const CALLIMPLEMENTBY: nat1 := 52
    const CASE: nat1 := 53
    const CAT: nat1 := 54
    const CHARSUBSTR1: nat1 := 55
    const CHARSUBSTR2: nat1 := 56
    const CHARTOCSTR: nat1 := 57
    const CHARTOSTR: nat1 := 58
    const CHARTOSTRLEFT: nat1 := 59
    
    const CHKCHRSTRSIZE: nat1 := 60
    const CHKCSTRRANGE: nat1 := 61
    const CHKRANGE: nat1 := 62
    const CHKSTRRANGE: nat1 := 63
    const CHKSTRSIZE: nat1 := 64
    const CLOSE: nat1 := 65
    const COPYARRAYDESC: nat1 := 66
    const CSTRTOCHAR: nat1 := 67
    const CSTRTOSTR: nat1 := 68
    const CSTRTOSTRLEFT: nat1 := 69
    
    const DEALLOCFLEXARRAY: nat1 := 70
    const DECSP: nat1 := 71
    const DIVINT: nat1 := 72
    const DIVNAT: nat1 := 73
    const DIVREAL: nat1 := 74
    const EMPTY: nat1 := 75
    const ENDFOR: nat1 := 76
    const EOF: nat1 := 77
    const EQADDR: nat1 := 78
    const EQCHARN: nat1 := 79
    
    const EQINT: nat1 := 80
    const EQINTNAT: nat1 := 81
    const EQNAT: nat1 := 82
    const EQREAL: nat1 := 83
    const EQSET: nat1 := 84
    const EQSTR: nat1 := 85
    const EXPINTINT: nat1 := 86
    const EXPREALINT: nat1 := 87
    const EXPREALREAL: nat1 := 88
    const FETCHADDR: nat1 := 89
    
    const FETCHBOOL: nat1 := 90
    const FETCHINT: nat1 := 91
    const FETCHINT1: nat1 := 92
    const FETCHINT2: nat1 := 93
    const FETCHINT4: nat1 := 94
    const FETCHNAT: nat1 := 95
    const FETCHNAT1: nat1 := 96
    const FETCHNAT2: nat1 := 97
    const FETCHNAT4: nat1 := 98
    const FETCHPTR: nat1 := 99
    
    const FETCHREAL: nat1 := 100
    const FETCHREAL4: nat1 := 101
    const FETCHREAL8: nat1 := 102
    const FETCHSET: nat1 := 103
    const FETCHSTR: nat1 := 104
    const FIELD: nat1 := 105
    const FOR: nat1 := 106
    const FORK: nat1 := 107
    const FREE: nat1 := 108
    const FREECLASS: nat1 := 109
    
    const FREEU: nat1 := 110
    const GECHARN: nat1 := 111
    const GECLASS: nat1 := 112
    const GEINT: nat1 := 113
    const GEINTNAT: nat1 := 114
    const GENAT: nat1 := 115
    const GENATINT: nat1 := 116
    const GEREAL: nat1 := 117
    const GESET: nat1 := 118
    const GESTR: nat1 := 119
    
    const GET: nat1 := 120
    const GETPRIORITY: nat1 := 121
    const GTCLASS: nat1 := 122
    const IF: nat1 := 123
    const IN: nat1 := 124
    const INCLINENO: nat1 := 125
    const INCSP: nat1 := 126
    const INFIXAND: nat1 := 127
    const INFIXOR: nat1 := 128
    const INITARRAYDESC: nat1 := 129
    
    const INITCONDITION: nat1 := 130
    const INITMONITOR: nat1 := 131
    const INITUNIT: nat1 := 132
    const INTREAL: nat1 := 133
    const INTREALLEFT: nat1 := 134
    const INTSTR: nat1 := 135
    const JSR: nat1 := 136
    const JUMP: nat1 := 137
    const JUMPB: nat1 := 138
    const LECHARN: nat1 := 139
    
    const LECLASS: nat1 := 140
    const LEINT: nat1 := 141
    const LEINTNAT: nat1 := 142
    const LENAT: nat1 := 143
    const LENATINT: nat1 := 144
    const LEREAL: nat1 := 145
    const LESET: nat1 := 146
    const LESTR: nat1 := 147
    const LOCATEARG: nat1 := 148
    const LOCATECLASS: nat1 := 149
    
    const LOCATELOC: nat1 := 150
    const LOCATEPARM: nat1 := 151
    const LOCATETEMP: nat1 := 152
    const LTCLASS: nat1 := 153
    const MAXINT: nat1 := 154
    const MAXNAT: nat1 := 155
    const MAXREAL: nat1 := 156
    const MININT: nat1 := 157
    const MINNAT: nat1 := 158
    const MINREAL: nat1 := 159
    
    const MODINT: nat1 := 160
    const MODNAT: nat1 := 161
    const MODREAL: nat1 := 162
    const MONITORENTER: nat1 := 163
    const MONITOREXIT: nat1 := 164
    const MULINT: nat1 := 165
    const MULNAT: nat1 := 166
    const MULREAL: nat1 := 167
    const MULSET: nat1 := 168
    const NATREAL: nat1 := 169
    
    const NATREALLEFT: nat1 := 170
    const NATSTR: nat1 := 171
    const NEGINT: nat1 := 172
    const NEGREAL: nat1 := 173
    const NEW: nat1 := 174
    const NEWARRAY: nat1 := 175
    const NEWCLASS: nat1 := 176
    const NEWU: nat1 := 177
    const NOT: nat1 := 178
    const NUMARRAYELEMENTS: nat1 := 179
    
    const OBJCLASS: nat1 := 180
    const OPEN: nat1 := 181
    const OR: nat1 := 182
    const ORD: nat1 := 183
    const PAUSE: nat1 := 184
    const PRED: nat1 := 185
    const PROC: nat1 := 186
    const PUSHADDR: nat1 := 187
    const PUSHADDR1: nat1 := 188
    const PUSHCOPY: nat1 := 189
    
    const PUSHINT: nat1 := 190
    const PUSHINT1: nat1 := 191
    const PUSHINT2: nat1 := 192
    const PUSHREAL: nat1 := 193
    const PUSHVAL0: nat1 := 194
    const PUSHVAL1: nat1 := 195
    const PUT: nat1 := 196
    const QUIT: nat1 := 197
    const READ: nat1 := 198
    const REALDIVIDE: nat1 := 199
    
    const REMINT: nat1 := 200
    const REMREAL: nat1 := 201
    const RESOLVEDEF: nat1 := 202
    const RESOLVEPTR: nat1 := 203
    const RESTORESP: nat1 := 204
    const RETURN: nat1 := 205
    const RTS: nat1 := 206
    const SAVESP: nat1 := 207
    const SEEK: nat1 := 208
    const SEEKSTAR: nat1 := 209
    
    const SETALL: nat1 := 210
    const SETCLR: nat1 := 211
    const SETELEMENT: nat1 := 212
    const SETFILENO: nat1 := 213
    const SETLINENO: nat1 := 214
    const SETPRIORITY: nat1 := 215
    const SETSTDSTREAM: nat1 := 216
    const SETSTREAM: nat1 := 217
    const SHL: nat1 := 218
    const SHR: nat1 := 219
    
    const SIGNAL: nat1 := 220
    const STRINT: nat1 := 221
    const STRINTOK: nat1 := 222
    const STRNAT: nat1 := 223
    const STRNATOK: nat1 := 224
    const STRTOCHAR: nat1 := 225
    const SUBINT: nat1 := 226
    const SUBINTNAT: nat1 := 227
    const SUBNAT: nat1 := 228
    const SUBNATINT: nat1 := 229
    
    const SUBREAL: nat1 := 230
    const SUBSCRIPT: nat1 := 231
    const SUBSET: nat1 := 232
    const SUBSTR1: nat1 := 233
    const SUBSTR2: nat1 := 234
    const SUCC: nat1 := 235
    const TAG: nat1 := 236
    const TELL: nat1 := 237
    const UFIELD: nat1 := 238
    const UNINIT: nat1 := 239
    
    const UNINITADDR: nat1 := 240
    const UNINITBOOLEAN: nat1 := 241
    const UNINITINT: nat1 := 242
    const UNINITNAT: nat1 := 243
    const UNINITREAL: nat1 := 244
    const UNINITSTR: nat1 := 245
    const UNLINKHANDLER: nat1 := 246
    const VSUBSCRIPT: nat1 := 247
    const WAIT: nat1 := 248
    const WRITE: nat1 := 249
    
    const XOR: nat1 := 250
    const XORSET: nat1 := 251
    const BREAK: nat1 := 252
    const SYSEXIT: nat1 := 253
    const ILLEGAL: nat1 := 254
    
    const argCount: array 0..254 of nat1 := init(
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 1, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 2, 0, 0,
        1, 1, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 4, 0, 0, 0, 0, 0, 0, 0,
        0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,   /* 99 */
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 2, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 1, 0, 0, 1, 0, 0, 0,
        0, 2, 0, 0, 0, 0, 0, 1, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 1, 1,
        1, 1, 2, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 1, 1, 2, 0,
        1, 1, 1, 2, 0, 0, 1, 0, 0, 0,   /* 199 */
        0, 0, 1, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 2, 1, 0, 1, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 3, 0, 0,
        0, 0, 0, 0, 0
    )
    
    const nameOf: array 0..254 of string(16) := init(
        "ABORT", "ABORTCOND", "ABSINT", "ABSREAL", "ADDINT", "ADDINTNAT", "ADDNAT", "ADDNATINT", "ADDREAL", "ADDSET",
        "ALLOCFLEXARRAY", "ALLOCGLOB", "ALLOCGLOBARRAY", "ALLOCLOC", "ALLOCLOCARRAY", "AND", "ARRAYUPPER", "ASNADDR", "ASNADDRINV", "ASNINT",
        "ASNINTINV", "ASNINT1", "ASNINT1INV", "ASNINT2", "ASNINT2INV", "ASNINT4", "ASNINT4INV", "ASNNAT", "ASNNATINV", "ASNNAT1",
        "ASNNAT1INV", "ASNNAT2", "ASNNAT2INV", "ASNNAT4", "ASNNAT4INV", "ASNNONSCALAR", "ASNNONSCALARINV", "ASNPTR", "ASNPTRINV", "ASNREAL",
        "ASNREALINV", "ASNREAL4", "ASNREAL4INV", "ASNREAL8", "ASNREAL8INV", "ASNSTR", "ASNSTRINV", "BEGINHANDLER", "BITSASSIGN", "BITSEXTRACT",
        "CALL", "CALLEXTERNAL", "CALLIMPLEMENTBY", "CASE", "CAT", "CHARSUBSTR1", "CHARSUBSTR2", "CHARTOCSTR", "CHARTOSTR", "CHARTOSTRLEFT",
        "CHKCHRSTRSIZE", "CHKCSTRRANGE", "CHKRANGE", "CHKSTRRANGE", "CHKSTRSIZE", "CLOSE", "COPYARRAYDESC", "CSTRTOCHAR", "CSTRTOSTR", "CSTRTOSTRLEFT",
        "DEALLOCFLEXARRAY", "DECSP", "DIVINT", "DIVNAT", "DIVREAL", "EMPTY", "ENDFOR", "EOF", "EQADDR", "EQCHARN",
        "EQINT", "EQINTNAT", "EQNAT", "EQREAL", "EQSET", "EQSTR", "EXPINTINT", "EXPREALINT", "EXPREALREAL", "FETCHADDR",
        "FETCHBOOL", "FETCHINT", "FETCHINT1", "FETCHINT2", "FETCHINT4", "FETCHNAT", "FETCHNAT1", "FETCHNAT2", "FETCHNAT4", "FETCHPTR",
        "FETCHREAL", "FETCHREAL4", "FETCHREAL8", "FETCHSET", "FETCHSTR", "FIELD", "FOR", "FORK", "FREE", "FREECLASS",
        "FREEU", "GECHARN", "GECLASS", "GEINT", "GEINTNAT", "GENAT", "GENATINT", "GEREAL", "GESET", "GESTR",
        "GET", "GETPRIORITY", "GTCLASS", "IF", "IN", "INCLINENO", "INCSP", "INFIXAND", "INFIXOR", "INITARRAYDESC",
        "INITCONDITION", "INITMONITOR", "INITUNIT", "INTREAL", "INTREALLEFT", "INTSTR", "JSR", "JUMP", "JUMPB", "LECHARN",
        "LECLASS", "LEINT", "LEINTNAT", "LENAT", "LENATINT", "LEREAL", "LESET", "LESTR", "LOCATEARG", "LOCATECLASS",
        "LOCATELOC", "LOCATEPARM", "LOCATETEMP", "LTCLASS", "MAXINT", "MAXNAT", "MAXREAL", "MININT", "MINNAT", "MINREAL",
        "MODINT", "MODNAT", "MODREAL", "MONITORENTER", "MONITOREXIT", "MULINT", "MULNAT", "MULREAL", "MULSET", "NATREAL",
        "NATREALLEFT", "NATSTR", "NEGINT", "NEGREAL", "NEW", "NEWARRAY", "NEWCLASS", "NEWU", "NOT", "NUMARRAYELEMENTS",
        "OBJCLASS", "OPEN", "OR", "ORD", "PAUSE", "PRED", "PROC", "PUSHADDR", "PUSHADDR1", "PUSHCOPY",
        "PUSHINT", "PUSHINT1", "PUSHINT2", "PUSHREAL", "PUSHVAL0", "PUSHVAL1", "PUT", "QUIT", "READ", "REALDIVIDE",
        "REMINT", "REMREAL", "RESOLVEDEF", "RESOLVEPTR", "RESTORESP", "RETURN", "RTS", "SAVESP", "SEEK", "SEEKSTAR",
        "SETALL", "SETCLR", "SETELEMENT", "SETFILENO", "SETLINENO", "SETPRIORITY", "SETSTDSTREAM", "SETSTREAM", "SHL", "SHR",
        "SIGNAL", "STRINT", "STRINTOK", "STRNAT", "STRNATOK", "STRTOCHAR", "SUBINT", "SUBINTNAT", "SUBNAT", "SUBNATINT",
        "SUBREAL", "SUBSCRIPT", "SUBSET", "SUBSTR1", "SUBSTR2", "SUCC", "TAG", "TELL", "UFIELD", "UNINIT",
        "UNINITADDR", "UNINITBOOLEAN", "UNINITINT", "UNINITNAT", "UNINITREAL", "UNINITSTR", "UNLINKHANDLER", "VSUBSCRIPT", "WAIT", "WRITE",
        "XOR", "XORSET", "BREAK", "SYSEXIT", "ILLEGAL"
    )
end Opcodes