lexer grammar smaliLexer;

//channels { CommentsChannel, DirectiveChannel }

tokens {
  //Lexer tokens
  ACCESS_SPEC,
  ANNOTATION_DIRECTIVE,
  ANNOTATION_VISIBILITY,
  ARRAY_DATA_DIRECTIVE,
  ARRAY_TYPE_PREFIX,
  ARROW,
  BOOL_LITERAL,
  BYTE_LITERAL,
  CATCH_DIRECTIVE,
  CATCHALL_DIRECTIVE,
  CHAR_LITERAL,
  CLASS_DESCRIPTOR,
  CLASS_DIRECTIVE,
  CLOSE_BRACE,
  CLOSE_PAREN,
  COLON,
  COMMA,
  DOTDOT,
  DOUBLE_LITERAL,
  DOUBLE_LITERAL_OR_ID,
  END_ANNOTATION_DIRECTIVE,
  END_ARRAY_DATA_DIRECTIVE,
  END_FIELD_DIRECTIVE,
  END_LOCAL_DIRECTIVE,
  END_METHOD_DIRECTIVE,
  END_PACKED_SWITCH_DIRECTIVE,
  END_PARAMETER_DIRECTIVE,
  END_SPARSE_SWITCH_DIRECTIVE,
  END_SUBANNOTATION_DIRECTIVE,
  ENUM_DIRECTIVE,
  EPILOGUE_DIRECTIVE,
  EQUAL,
  FIELD_DIRECTIVE,
  FIELD_OFFSET,
  FLOAT_LITERAL,
  FLOAT_LITERAL_OR_ID,
  IMPLEMENTS_DIRECTIVE,
  INLINE_INDEX,
  INSTRUCTION_FORMAT10t,
  INSTRUCTION_FORMAT10x,
  INSTRUCTION_FORMAT10x_ODEX,
  INSTRUCTION_FORMAT11n,
  INSTRUCTION_FORMAT11x,
  INSTRUCTION_FORMAT12x,
  INSTRUCTION_FORMAT12x_OR_ID,
  INSTRUCTION_FORMAT20bc,
  INSTRUCTION_FORMAT20t,
  INSTRUCTION_FORMAT21c_FIELD,
  INSTRUCTION_FORMAT21c_FIELD_ODEX,
  INSTRUCTION_FORMAT21c_STRING,
  INSTRUCTION_FORMAT21c_TYPE,
  INSTRUCTION_FORMAT21ih,
  INSTRUCTION_FORMAT21lh,
  INSTRUCTION_FORMAT21s,
  INSTRUCTION_FORMAT21t,
  INSTRUCTION_FORMAT22b,
  INSTRUCTION_FORMAT22c_FIELD,
  INSTRUCTION_FORMAT22c_FIELD_ODEX,
  INSTRUCTION_FORMAT22c_TYPE,
  INSTRUCTION_FORMAT22cs_FIELD,
  INSTRUCTION_FORMAT22s,
  INSTRUCTION_FORMAT22s_OR_ID,
  INSTRUCTION_FORMAT22t,
  INSTRUCTION_FORMAT22x,
  INSTRUCTION_FORMAT23x,
  INSTRUCTION_FORMAT30t,
  INSTRUCTION_FORMAT31c,
  INSTRUCTION_FORMAT31i,
  INSTRUCTION_FORMAT31i_OR_ID,
  INSTRUCTION_FORMAT31t,
  INSTRUCTION_FORMAT32x,
  INSTRUCTION_FORMAT35c_METHOD,
  INSTRUCTION_FORMAT35c_METHOD_ODEX,
  INSTRUCTION_FORMAT35c_TYPE,
  INSTRUCTION_FORMAT35mi_METHOD,
  INSTRUCTION_FORMAT35ms_METHOD,
  INSTRUCTION_FORMAT3rc_METHOD,
  INSTRUCTION_FORMAT3rc_METHOD_ODEX,
  INSTRUCTION_FORMAT3rc_TYPE,
  INSTRUCTION_FORMAT3rmi_METHOD,
  INSTRUCTION_FORMAT3rms_METHOD,
  INSTRUCTION_FORMAT45cc_METHOD,
  INSTRUCTION_FORMAT4rcc_METHOD,
  INSTRUCTION_FORMAT51l,
  LINE_COMMENT,
  LINE_DIRECTIVE,
  LOCAL_DIRECTIVE,
  LOCALS_DIRECTIVE,
  LONG_LITERAL,
  METHOD_DIRECTIVE,
  MEMBER_NAME,
  NEGATIVE_INTEGER_LITERAL,
  NULL_LITERAL,
  OPEN_BRACE,
  OPEN_PAREN,
  PACKED_SWITCH_DIRECTIVE,
  PARAM_LIST_OR_ID_PRIMITIVE_TYPE,
  PARAMETER_DIRECTIVE,
  POSITIVE_INTEGER_LITERAL,
  PRIMITIVE_TYPE,
  PROLOGUE_DIRECTIVE,
  REGISTER,
  REGISTERS_DIRECTIVE,
  RESTART_LOCAL_DIRECTIVE,
  SHORT_LITERAL,
  SIMPLE_NAME,
  SOURCE_DIRECTIVE,
  SPARSE_SWITCH_DIRECTIVE,
  STRING_LITERAL,
  SUBANNOTATION_DIRECTIVE,
  SUPER_DIRECTIVE,
  VERIFICATION_ERROR_TYPE,
  VOID_TYPE,
  VTABLE_INDEX,
  WHITE_SPACE,

  // misc non-lexer tokens
  INTEGER_LITERAL,
  INVALID_TOKEN,

  //I_* tokens are imaginary tokens used as parent AST nodes
  I_CLASS_DEF,
  I_SUPER,
  I_IMPLEMENTS,
  I_SOURCE,
  I_ACCESS_LIST,
  I_METHODS,
  I_FIELDS,
  I_FIELD,
  I_FIELD_TYPE,
  I_FIELD_INITIAL_VALUE,
  I_METHOD,
  I_METHOD_PROTOTYPE,
  I_METHOD_RETURN_TYPE,
  I_REGISTERS,
  I_LOCALS,
  I_LABEL,
  I_ANNOTATIONS,
  I_ANNOTATION,
  I_ANNOTATION_ELEMENT,
  I_SUBANNOTATION,
  I_ENCODED_FIELD,
  I_ENCODED_METHOD,
  I_ENCODED_ENUM,
  I_ENCODED_ARRAY,
  I_ARRAY_ELEMENT_SIZE,
  I_ARRAY_ELEMENTS,
  I_PACKED_SWITCH_START_KEY,
  I_PACKED_SWITCH_ELEMENTS,
  I_SPARSE_SWITCH_ELEMENTS,
  I_CATCH,
  I_CATCHALL,
  I_CATCHES,
  I_PARAMETER,
  I_PARAMETERS,
  I_PARAMETER_NOT_SPECIFIED,
  I_LINE,
  I_LOCAL,
  I_END_LOCAL,
  I_RESTART_LOCAL,
  I_PROLOGUE,
  I_EPILOGUE,
  I_ORDERED_METHOD_ITEMS,
  I_STATEMENT_FORMAT10t,
  I_STATEMENT_FORMAT10x,
  I_STATEMENT_FORMAT11n,
  I_STATEMENT_FORMAT11x,
  I_STATEMENT_FORMAT12x,
  I_STATEMENT_FORMAT20bc,
  I_STATEMENT_FORMAT20t,
  I_STATEMENT_FORMAT21c_TYPE,
  I_STATEMENT_FORMAT21c_FIELD,
  I_STATEMENT_FORMAT21c_STRING,
  I_STATEMENT_FORMAT21ih,
  I_STATEMENT_FORMAT21lh,
  I_STATEMENT_FORMAT21s,
  I_STATEMENT_FORMAT21t,
  I_STATEMENT_FORMAT22b,
  I_STATEMENT_FORMAT22c_FIELD,
  I_STATEMENT_FORMAT22c_TYPE,
  I_STATEMENT_FORMAT22s,
  I_STATEMENT_FORMAT22t,
  I_STATEMENT_FORMAT22x,
  I_STATEMENT_FORMAT23x,
  I_STATEMENT_FORMAT30t,
  I_STATEMENT_FORMAT31c,
  I_STATEMENT_FORMAT31i,
  I_STATEMENT_FORMAT31t,
  I_STATEMENT_FORMAT32x,
  I_STATEMENT_FORMAT35c_METHOD,
  I_STATEMENT_FORMAT35c_TYPE,
  I_STATEMENT_FORMAT3rc_METHOD,
  I_STATEMENT_FORMAT3rc_TYPE,
  I_STATEMENT_FORMAT45cc_METHOD,
  I_STATEMENT_FORMAT4rcc_METHOD,
  I_STATEMENT_FORMAT51l,
  I_STATEMENT_ARRAY_DATA,
  I_STATEMENT_PACKED_SWITCH,
  I_STATEMENT_SPARSE_SWITCH,
  I_REGISTER_RANGE,
  I_REGISTER_LIST
}

ARRAY_TYPE_PREFIX: '['+;
PRIMITIVE_TYPE: [ZBSCIJFD]+;

POSITIVE_INTEGER_LITERAL: INTEGER;
NEGATIVE_INTEGER_LITERAL: '-' INTEGER;
LONG_LITERAL: '-'? INTEGER [lL];
SHORT_LITERAL: '-'? INTEGER [sS];
BYTE_LITERAL: '-'? INTEGER [tT];

CLASS_DIRECTIVE: '.class';
SUPER_DIRECTIVE: '.super';
IMPLEMENTS_DIRECTIVE: '.implements';
SOURCE_DIRECTIVE: '.source';
FIELD_DIRECTIVE: '.field';
END_FIELD_DIRECTIVE: '.end field';
SUBANNOTATION_DIRECTIVE: '.subannotation';
END_SUBANNOTATION_DIRECTIVE: '.end subannotation';
ANNOTATION_DIRECTIVE: '.annotation';
END_ANNOTATION_DIRECTIVE: '.end annotation';
ENUM_DIRECTIVE: '.enum';
METHOD_DIRECTIVE: '.method';
END_METHOD_DIRECTIVE: '.end method';
REGISTERS_DIRECTIVE: '.registers';
LOCALS_DIRECTIVE: '.locals';
ARRAY_DATA_DIRECTIVE: '.array-data';
END_ARRAY_DATA_DIRECTIVE: '.end array-data';
PACKED_SWITCH_DIRECTIVE: '.packed-switch';
END_PACKED_SWITCH_DIRECTIVE: '.end packed-switch';
SPARSE_SWITCH_DIRECTIVE: '.sparse-switch';
END_SPARSE_SWITCH_DIRECTIVE: '.end sparse-switch';
CATCH_DIRECTIVE: '.catch';
CATCHALL_DIRECTIVE: '.catchall';
LINE_DIRECTIVE: '.line';
PARAMETER_DIRECTIVE: '.param';
END_PARAMETER_DIRECTIVE: '.end param';
LOCAL_DIRECTIVE: '.local';
END_LOCAL_DIRECTIVE: '.end local';
RESTART_LOCAL_DIRECTIVE: '.restart local';
PROLOGUE_DIRECTIVE: '.prologue';
EPILOGUE_DIRECTIVE: '.epilogue';
// '.end' { return invalidToken('Invalid directive'); }
// ".end " [a-zA-z0-9\-_]+ { return invalidToken("Invalid directive"); }
// ".restart" { return invalidToken("Invalid directive"); }
// ".restart " [a-zA-z0-9\-_]+ { return invalidToken("Invalid directive"); }

ACCESS_SPEC:
    'public' | 'private' | 'protected' | 'static' | 'final' | 'synchronized' | 'bridge' | 'varargs' | 'native' |
    'abstract' | 'strictfp' | 'synthetic' | 'constructor' | 'declared-synchronized' | 'interface' | 'enum' |
    'annotation' | 'volatile' | 'transient'
	;


REGISTER: [vp][0-9]+;

ANNOTATION_VISIBILITY:    'build' | 'runtime' | 'system';
VERIFICATION_ERROR_TYPE:
    'no-error' | 'generic-error' | 'no-such-class' | 'no-such-field' | 'no-such-method' | 'illegal-class-access' |
    'illegal-field-access' | 'illegal-method-access' | 'class-change-error' | 'instantiation-error';

BOOL_LITERAL
	:	'true'
	|	'false'
	;
INLINE_INDEX: 'inline@0x' HexDigit+;
VTABLE_INDEX: 'vtable@0x' HexDigit+;
FIELD_OFFSET: 'field@0x' HexDigit+;

LINE_COMMENT : ('#' ~('\r' | '\n')* '\r'? '\n') -> skip;

INSTRUCTION_FORMAT10t: 'goto'; 
INSTRUCTION_FORMAT10x: 'return-void' | 'nop';
INSTRUCTION_FORMAT10x_ODEX:
    'return-void-barrier' | 'return-void-no-barrier';
INSTRUCTION_FORMAT11n:    'const/4'; 
INSTRUCTION_FORMAT11x: 'move-result' | 'move-result-wide' | 'move-result-object' | 'move-exception' | 'return' | 'return-wide' | 'return-object' | 'monitor-enter' | 'monitor-exit' | 'throw';

INSTRUCTION_FORMAT12x_OR_ID: 'move' | 'move-wide' | 'move-object' | 'array-length' | 'neg-int' | 'not-int' | 'neg-long' | 'not-long' | 'neg-float' | 'neg-double' | 'int-to-long' | 'int-to-float' | 'int-to-double' | 'long-to-int' | 'long-to-float' | 'long-to-double' | 'float-to-int' | 'float-to-long' | 'float-to-double' | 'double-to-int' | 'double-to-long' | 'double-to-float' | 'int-to-byte' | 'int-to-char' | 'int-to-short';

INSTRUCTION_FORMAT12x: 'add-int/2addr' | 'sub-int/2addr' | 'mul-int/2addr' | 'div-int/2addr' | 'rem-int/2addr' | 'and-int/2addr' | 'or-int/2addr' | 'xor-int/2addr' | 'shl-int/2addr' | 'shr-int/2addr' | 'ushr-int/2addr' | 'add-long/2addr' | 'sub-long/2addr' | 'mul-long/2addr' | 'div-long/2addr' | 'rem-long/2addr' | 'and-long/2addr' | 'or-long/2addr' | 'xor-long/2addr' | 'shl-long/2addr' | 'shr-long/2addr' | 'ushr-long/2addr' | 'add-float/2addr' | 'sub-float/2addr' | 'mul-float/2addr' | 'div-float/2addr' | 'rem-float/2addr' | 'add-double/2addr' | 'sub-double/2addr' | 'mul-double/2addr' | 'div-double/2addr' | 'rem-double/2addr';

INSTRUCTION_FORMAT20bc: 'throw-verification-error';

INSTRUCTION_FORMAT20t: 'goto/16';

INSTRUCTION_FORMAT21c_FIELD: 'sget' | 'sget-wide' | 'sget-object' | 'sget-boolean' | 'sget-byte' | 'sget-char' | 'sget-short' | 'sput' | 'sput-wide' | 'sput-object' | 'sput-boolean' | 'sput-byte' | 'sput-char' | 'sput-short';

INSTRUCTION_FORMAT21c_FIELD_ODEX: 'sget-volatile' | 'sget-wide-volatile' | 'sget-object-volatile' | 'sput-volatile' | 'sput-wide-volatile' | 'sput-object-volatile';

INSTRUCTION_FORMAT21c_STRING: 'const-string';

INSTRUCTION_FORMAT21c_TYPE: 'check-cast' | 'new-instance' | 'const-class';

INSTRUCTION_FORMAT21ih: 'const/high16';

INSTRUCTION_FORMAT21lh: 'const-wide/high16';

INSTRUCTION_FORMAT21s: 'const/16' | 'const-wide/16';

INSTRUCTION_FORMAT21t: 'if-eqz' | 'if-nez' | 'if-ltz' | 'if-gez' | 'if-gtz' | 'if-lez';

INSTRUCTION_FORMAT22b: 'add-int/lit8' | 'rsub-int/lit8' | 'mul-int/lit8' | 'div-int/lit8' | 'rem-int/lit8' | 'and-int/lit8' | 'or-int/lit8' | 'xor-int/lit8' | 'shl-int/lit8' | 'shr-int/lit8' | 'ushr-int/lit8';

INSTRUCTION_FORMAT22c_FIELD: 'iget' | 'iget-wide' | 'iget-object' | 'iget-boolean' | 'iget-byte' | 'iget-char' | 'iget-short' | 'iput' | 'iput-wide' | 'iput-object' | 'iput-boolean' | 'iput-byte' | 'iput-char' | 'iput-short';

INSTRUCTION_FORMAT22c_FIELD_ODEX: 'iget-volatile' | 'iget-wide-volatile' | 'iget-object-volatile' | 'iput-volatile' | 'iput-wide-volatile' | 'iput-object-volatile';

INSTRUCTION_FORMAT22c_TYPE: 'instance-of' | 'new-array';

INSTRUCTION_FORMAT22cs_FIELD: 'iget-quick' | 'iget-wide-quick' | 'iget-object-quick' | 'iput-quick' | 'iput-wide-quick' | 'iput-object-quick' | 'iput-boolean-quick' | 'iput-byte-quick' | 'iput-char-quick' | 'iput-short-quick';

INSTRUCTION_FORMAT22s_OR_ID: 'rsub-int';

INSTRUCTION_FORMAT22s: 'add-int/lit16' | 'mul-int/lit16' | 'div-int/lit16' | 'rem-int/lit16' | 'and-int/lit16' | 'or-int/lit16' | 'xor-int/lit16';

INSTRUCTION_FORMAT22t: 'if-eq' | 'if-ne' | 'if-lt' | 'if-ge' | 'if-gt' | 'if-le';

INSTRUCTION_FORMAT22x: 'move/from16' | 'move-wide/from16' | 'move-object/from16';

INSTRUCTION_FORMAT23x: 'cmpl-float' | 'cmpg-float' | 'cmpl-double' | 'cmpg-double' | 'cmp-long' | 'aget' | 'aget-wide' | 'aget-object' | 'aget-boolean' | 'aget-byte' | 'aget-char' | 'aget-short' | 'aput' | 'aput-wide' | 'aput-object' | 'aput-boolean' | 'aput-byte' | 'aput-char' | 'aput-short' | 'add-int' | 'sub-int' | 'mul-int' | 'div-int' | 'rem-int' | 'and-int' | 'or-int' | 'xor-int' | 'shl-int' | 'shr-int' | 'ushr-int' | 'add-long' | 'sub-long' | 'mul-long' | 'div-long' | 'rem-long' | 'and-long' | 'or-long' | 'xor-long' | 'shl-long' | 'shr-long' | 'ushr-long' | 'add-float' | 'sub-float' | 'mul-float' | 'div-float' | 'rem-float' | 'add-double' | 'sub-double' | 'mul-double' | 'div-double' | 'rem-double';

INSTRUCTION_FORMAT30t: 'goto/32';

INSTRUCTION_FORMAT31c: 'const-string/jumbo';

INSTRUCTION_FORMAT31i_OR_ID: 'const';

INSTRUCTION_FORMAT31i: 'const-wide/32';

INSTRUCTION_FORMAT31t: 'fill-array-data' | 'packed-switch' | 'sparse-switch';

INSTRUCTION_FORMAT32x: 'move/16' | 'move-wide/16' | 'move-object/16';

INSTRUCTION_FORMAT35c_METHOD: 'invoke-virtual' | 'invoke-super' | 'invoke-direct' | 'invoke-static' | 'invoke-interface';

INSTRUCTION_FORMAT35c_METHOD_ODEX: 'invoke-direct-empty';

INSTRUCTION_FORMAT35c_TYPE: 'filled-new-array';

INSTRUCTION_FORMAT35mi_METHOD: 'execute-inline';

INSTRUCTION_FORMAT35ms_METHOD: 'invoke-virtual-quick' | 'invoke-super-quick';

INSTRUCTION_FORMAT3rc_METHOD: 'invoke-virtual/range' | 'invoke-super/range' | 'invoke-direct/range' | 'invoke-static/range' | 'invoke-interface/range';

INSTRUCTION_FORMAT3rc_METHOD_ODEX: 'invoke-object-init/range';

INSTRUCTION_FORMAT3rc_TYPE: 'filled-new-array/range';

INSTRUCTION_FORMAT3rmi_METHOD: 'execute-inline/range';

INSTRUCTION_FORMAT3rms_METHOD: 'invoke-virtual-quick/range' | 'invoke-super-quick/range';

INSTRUCTION_FORMAT45cc_METHOD: 'invoke-polymorphic';

INSTRUCTION_FORMAT4rcc_METHOD:   'invoke-polymorphic/range';
INSTRUCTION_FORMAT51l: 'const-wide';

OPEN_PAREN: '(';
CLOSE_PAREN: ')';
OPEN_BRACE: '{';
CLOSE_BRACE: '}';
DOTDOT: '..';
ARROW: '->';
EQUAL: '=';
COLON: ':';
COMMA: ',';

NULL_LITERAL
	:	'null'
	;
VOID_TYPE: 'V';
HexPrefix: '0'[xX];
fragment
   HexDigit: [0-9a-fA-F];
Integer1: '0';
Integer2: [1-9][0-9]*;
Integer3: '0'[0-7]+;
Integer4: HexPrefix HexDigit+;
Integer5: 'Infinity';
INTEGER: Integer1 | Integer2 | Integer3 | Integer4 | Integer5;
HighSurrogate: [\uD800-\uDBFF];
LowSurrogate: [\uDC00-\uDFFF];
fragment 
	SimpleNameCharacterMinus: (HighSurrogate LowSurrogate) | [A-Za-z0-9$\-_\u00a1-\u1fff\u2010-\u2027\u2030-\ud7ff\ue000-\uffef];
fragment 
	SimpleNameCharacter: (HighSurrogate LowSurrogate) | [A-Za-z0-9$_\u00a1-\u1fff\u2010-\u2027\u2030-\ud7ff\ue000-\uffef];

SIMPLE_NAME: SimpleNameCharacterMinus* SimpleNameCharacter;

// ARRAY_DESCRIPTOR: ARRAY_TYPE_PREFIX PRIMITIVE_TYPE CLASS_DESCRIPTOR [^] EOF;
ARRAY_DESCRIPTOR: PRIMITIVE_TYPE CLASS_DESCRIPTOR [^] EOF;


MEMBER_NAME: '<' SIMPLE_NAME '>';
SIMPLE_NAME_SLASH: SIMPLE_NAME '/';
CLASS_DESCRIPTOR: PRIMITIVE_TYPE? 'L' SIMPLE_NAME_SLASH* SIMPLE_NAME ';';
DecimalExponent: [eE] '-'? [0-9]+;
BinaryExponent: [pP] '-'? [0-9]+;

FloatOrID1: '-'? [0-9]+ DecimalExponent?;
FloatOrID2: '-'? HexPrefix HexDigit+ BinaryExponent;
FloatOrID3: '-'? [iI][nN][fF][iI][nN][iI][tT][yY];
FloatOrID4: [nN][aA][nN];
FloatOrID:  FloatOrID1 | FloatOrID2 | FloatOrID3 | FloatOrID4;

fragment
	Float1: '-'? [0-9]+ '.' [0-9]* DecimalExponent?;
fragment
	Float2: '-'? '.' [0-9]+ DecimalExponent?;
fragment
	Float3: '-'? HexPrefix HexDigit+ '.' HexDigit* BinaryExponent;
fragment
	Float4: '-'? HexPrefix '.' HexDigit+ BinaryExponent;
fragment
	Float:  Float1 | Float2 | Float3 | Float4;
FLOAT_LITERAL_OR_ID: FloatOrID | FloatOrID [fF] | '-'?[0-9]+[fF];
DOUBLE_LITERAL_OR_ID: FloatOrID [dD] | '-'?[0-9]+[dD];
FLOAT_LITERAL: Float | Float [fF];
DOUBLE_LITERAL: Float [dD];

PARAM_LIST_OR_ID: PRIMITIVE_TYPE [^] EOF;
PARAM_LIST: PRIMITIVE_TYPE CLASS_DESCRIPTOR [^] EOF;
PARAM_LIST_OR_ID_PRIMITIVE_TYPE: PARAM_LIST_OR_ID | PARAM_LIST;

fragment
OctalDigitsAndUnderscores
        :       OctalDigitOrUnderscore+
        ;

fragment
OctalDigitOrUnderscore
        :       OctalDigit
        |       '_'
        ;

// §3.10.3 Boolean Literals


// §3.10.4 Character Literals

CHAR_LITERAL
	:	'\'' SingleCharacter '\''
	|	'\'' EscapeSequence '\''
	;

fragment
SingleCharacter
	:	~['\\]
	;

// §3.10.5 String Literals

STRING_LITERAL
	:	'"' StringCharacters? '"'
	;

fragment
StringCharacters
	:	StringCharacter+
	;

fragment
StringCharacter
	:	~["\\]
	|	EscapeSequence
	;

// §3.10.6 Escape Sequences for Character and String Literals

fragment
EscapeSequence
	:	'\\' [btnfr"'\\]
	|	OctalEscape
    |   UnicodeEscape // This is not in the spec but prevents having to preprocess the input
	;

/*
fragment
HexDigitOrUnderscore
	:	HexDigit
	|	'_'
	;
*/

fragment
OctalNumeral
	:	'0' Underscores? OctalDigits
	;

fragment
OctalDigits
	:	OctalDigit (OctalDigitsAndUnderscores? OctalDigit)?
	;

fragment
OctalDigit
	:	[0-7]
	;

fragment
OctalEscape
	:	'\\' OctalDigit
	|	'\\' OctalDigit OctalDigit
	|	'\\' ZeroToThree OctalDigit OctalDigit
	;

fragment
ZeroToThree
	:	[0-3]
	;

fragment
Underscores
        :       '_'+
        ;

// This is not in the spec but prevents having to preprocess the input
fragment
UnicodeEscape
    :   '\\' 'u' HexDigit HexDigit HexDigit HexDigit
    ;

/* TYPE: PRIMITIVE_TYPE 
     | CLASS_DESCRIPTOR 
     | ARRAY_TYPE_PREFIX CLASS_DESCRIPTOR
     | ARRAY_TYPE_PREFIX PRIMITIVE_TYPE;
*/

WS: [ \t\r\n]+ -> channel(99);
