// automatically generated by the FlatBuffers compiler, do not modify


#ifndef FLATBUFFERS_GENERATED_FAST__FAST__ELEMENT_H_
#define FLATBUFFERS_GENERATED_FAST__FAST__ELEMENT_H_

#include "flatbuffers/flatbuffers.h"

namespace _fast {

struct Element;

namespace _Element {

struct Anonymous0;

struct Unit;

struct Literal;

enum Kind {
  Kind_UNIT_KIND = 0,
  Kind_DECL = 1,
  Kind_DECL_STMT = 2,
  Kind_INIT = 3,
  Kind_EXPR = 4,
  Kind_EXPR_STMT = 5,
  Kind_COMMENT = 6,
  Kind_CALL = 7,
  Kind_CONTROL = 8,
  Kind_INCR = 9,
  Kind_NONE = 10,
  Kind_VARIABLE = 11,
  Kind_FUNCTION = 12,
  Kind_FUNCTION_DECL = 13,
  Kind_CONSTRUCTOR = 14,
  Kind_CONSTRUCTOR_DECL = 15,
  Kind_DESTRUCTOR = 16,
  Kind_DESTRUCTOR_DECL = 17,
  Kind_MACRO = 18,
  Kind_SINGLE_MACRO = 19,
  Kind_NULLOPERATOR = 20,
  Kind_ENUM_DEFN = 21,
  Kind_ENUM_DECL = 22,
  Kind_GLOBAL_ATTRIBUTE = 23,
  Kind_PROPERTY_ACCESSOR = 24,
  Kind_PROPERTY_ACCESSOR_DECL = 25,
  Kind_EXPRESSION = 26,
  Kind_CLASS_DEFN = 27,
  Kind_CLASS_DECL = 28,
  Kind_UNION_DEFN = 29,
  Kind_UNION_DECL = 30,
  Kind_STRUCT_DEFN = 31,
  Kind_STRUCT_DECL = 32,
  Kind_INTERFACE_DEFN = 33,
  Kind_INTERFACE_DECL = 34,
  Kind_ACCESS_REGION = 35,
  Kind_USING = 36,
  Kind_OPERATOR_FUNCTION = 37,
  Kind_OPERATOR_FUNCTION_DECL = 38,
  Kind_EVENT = 39,
  Kind_PROPERTY = 40,
  Kind_ANNOTATION_DEFN = 41,
  Kind_GLOBAL_TEMPLATE = 42,
  Kind_UNIT = 43,
  Kind_TART_ELEMENT_TOKEN = 44,
  Kind_NOP = 45,
  Kind_STRING = 46,
  Kind_CHAR = 47,
  Kind_LITERAL = 48,
  Kind_BOOLEAN = 49,
  Kind_NULL = 50,
  Kind_COMPLEX = 51,
  Kind_OPERATOR = 52,
  Kind_MODIFIER = 53,
  Kind_NAME = 54,
  Kind_ONAME = 55,
  Kind_CNAME = 56,
  Kind_TYPE = 57,
  Kind_TYPEPREV = 58,
  Kind_CONDITION = 59,
  Kind_BLOCK = 60,
  Kind_PSEUDO_BLOCK = 61,
  Kind_INDEX = 62,
  Kind_ENUM = 63,
  Kind_ENUM_DECLARATION = 64,
  Kind_IF_STATEMENT = 65,
  Kind_TERNARY = 66,
  Kind_THEN = 67,
  Kind_ELSE = 68,
  Kind_ELSEIF = 69,
  Kind_WHILE_STATEMENT = 70,
  Kind_DO_STATEMENT = 71,
  Kind_FOR_STATEMENT = 72,
  Kind_FOREACH_STATEMENT = 73,
  Kind_FOR_CONTROL = 74,
  Kind_FOR_INITIALIZATION = 75,
  Kind_FOR_CONDITION = 76,
  Kind_FOR_INCREMENT = 77,
  Kind_FOR_LIKE_CONTROL = 78,
  Kind_EXPRESSION_STATEMENT = 79,
  Kind_FUNCTION_CALL = 80,
  Kind_DECLARATION_STATEMENT = 81,
  Kind_DECLARATION = 82,
  Kind_DECLARATION_INITIALIZATION = 83,
  Kind_DECLARATION_RANGE = 84,
  Kind_RANGE = 85,
  Kind_GOTO_STATEMENT = 86,
  Kind_CONTINUE_STATEMENT = 87,
  Kind_BREAK_STATEMENT = 88,
  Kind_LABEL_STATEMENT = 89,
  Kind_LABEL = 90,
  Kind_SWITCH = 91,
  Kind_CASE = 92,
  Kind_DEFAULT = 93,
  Kind_FUNCTION_DEFINITION = 94,
  Kind_FUNCTION_DECLARATION = 95,
  Kind_LAMBDA = 96,
  Kind_FUNCTION_LAMBDA = 97,
  Kind_FUNCTION_SPECIFIER = 98,
  Kind_RETURN_STATEMENT = 99,
  Kind_PARAMETER_LIST = 100,
  Kind_PARAMETER = 101,
  Kind_KRPARAMETER_LIST = 102,
  Kind_KRPARAMETER = 103,
  Kind_ARGUMENT_LIST = 104,
  Kind_ARGUMENT = 105,
  Kind_PSEUDO_PARAMETER_LIST = 106,
  Kind_INDEXER_PARAMETER_LIST = 107,
  Kind_CLASS = 108,
  Kind_CLASS_DECLARATION = 109,
  Kind_STRUCT = 110,
  Kind_STRUCT_DECLARATION = 111,
  Kind_UNION = 112,
  Kind_UNION_DECLARATION = 113,
  Kind_DERIVATION_LIST = 114,
  Kind_PUBLIC_ACCESS = 115,
  Kind_PUBLIC_ACCESS_DEFAULT = 116,
  Kind_PRIVATE_ACCESS = 117,
  Kind_PRIVATE_ACCESS_DEFAULT = 118,
  Kind_PROTECTED_ACCESS = 119,
  Kind_PROTECTED_ACCESS_DEFAULT = 120,
  Kind_MEMBER_INIT_LIST = 121,
  Kind_MEMBER_INITIALIZATION_LIST = 122,
  Kind_MEMBER_INITIALIZATION = 123,
  Kind_CONSTRUCTOR_DEFINITION = 124,
  Kind_CONSTRUCTOR_DECLARATION = 125,
  Kind_DESTRUCTOR_DEFINITION = 126,
  Kind_DESTRUCTOR_DECLARATION = 127,
  Kind_FRIEND = 128,
  Kind_CLASS_SPECIFIER = 129,
  Kind_TRY_BLOCK = 130,
  Kind_CATCH_BLOCK = 131,
  Kind_FINALLY_BLOCK = 132,
  Kind_THROW_STATEMENT = 133,
  Kind_THROW_SPECIFIER = 134,
  Kind_THROW_SPECIFIER_JAVA = 135,
  Kind_TEMPLATE = 136,
  Kind_GENERIC_ARGUMENT = 137,
  Kind_GENERIC_ARGUMENT_LIST = 138,
  Kind_TEMPLATE_PARAMETER = 139,
  Kind_TEMPLATE_PARAMETER_LIST = 140,
  Kind_GENERIC_PARAMETER = 141,
  Kind_GENERIC_PARAMETER_LIST = 142,
  Kind_TYPEDEF = 143,
  Kind_ASM = 144,
  Kind_MACRO_CALL = 145,
  Kind_SIZEOF_CALL = 146,
  Kind_EXTERN = 147,
  Kind_NAMESPACE = 148,
  Kind_USING_DIRECTIVE = 149,
  Kind_DIRECTIVE = 150,
  Kind_ATOMIC = 151,
  Kind_STATIC_ASSERT_STATEMENT = 152,
  Kind_GENERIC_SELECTION = 153,
  Kind_GENERIC_SELECTOR = 154,
  Kind_GENERIC_ASSOCIATION_LIST = 155,
  Kind_GENERIC_ASSOCIATION = 156,
  Kind_ALIGNAS = 157,
  Kind_DECLTYPE = 158,
  Kind_CAPTURE = 159,
  Kind_LAMBDA_CAPTURE = 160,
  Kind_NOEXCEPT = 161,
  Kind_TYPENAME = 162,
  Kind_ALIGNOF = 163,
  Kind_TYPEID = 164,
  Kind_SIZEOF_PACK = 165,
  Kind_ENUM_CLASS = 166,
  Kind_ENUM_CLASS_DECLARATION = 167,
  Kind_REF_QUALIFIER = 168,
  Kind_SIGNAL_ACCESS = 169,
  Kind_FOREVER_STATEMENT = 170,
  Kind_EMIT_STATEMENT = 171,
  Kind_CPP_DIRECTIVE = 172,
  Kind_CPP_FILENAME = 173,
  Kind_FILE = 174,
  Kind_NUMBER = 175,
  Kind_CPP_NUMBER = 176,
  Kind_CPP_LITERAL = 177,
  Kind_CPP_MACRO_DEFN = 178,
  Kind_CPP_MACRO_VALUE = 179,
  Kind_ERROR = 180,
  Kind_CPP_ERROR = 181,
  Kind_CPP_WARNING = 182,
  Kind_CPP_PRAGMA = 183,
  Kind_CPP_INCLUDE = 184,
  Kind_CPP_DEFINE = 185,
  Kind_CPP_UNDEF = 186,
  Kind_CPP_LINE = 187,
  Kind_CPP_IF = 188,
  Kind_CPP_IFDEF = 189,
  Kind_CPP_IFNDEF = 190,
  Kind_CPP_THEN = 191,
  Kind_CPP_ELSE = 192,
  Kind_CPP_ELIF = 193,
  Kind_CPP_EMPTY = 194,
  Kind_CPP_REGION = 195,
  Kind_CPP_ENDREGION = 196,
  Kind_USING_STMT = 197,
  Kind_ESCAPE = 198,
  Kind_VALUE = 199,
  Kind_CPP_IMPORT = 200,
  Kind_CPP_ENDIF = 201,
  Kind_MARKER = 202,
  Kind_ERROR_PARSE = 203,
  Kind_ERROR_MODE = 204,
  Kind_IMPLEMENTS = 205,
  Kind_EXTENDS = 206,
  Kind_IMPORT = 207,
  Kind_PACKAGE = 208,
  Kind_ASSERT_STATEMENT = 209,
  Kind_INTERFACE = 210,
  Kind_INTERFACE_DECLARATION = 211,
  Kind_SYNCHRONIZED_STATEMENT = 212,
  Kind_ANNOTATION = 213,
  Kind_STATIC_BLOCK = 214,
  Kind_CHECKED_STATEMENT = 215,
  Kind_UNCHECKED_STATEMENT = 216,
  Kind_ATTRIBUTE = 217,
  Kind_TARGET = 218,
  Kind_UNSAFE_STATEMENT = 219,
  Kind_LOCK_STATEMENT = 220,
  Kind_FIXED_STATEMENT = 221,
  Kind_TYPEOF = 222,
  Kind_USING_STATEMENT = 223,
  Kind_FUNCTION_DELEGATE = 224,
  Kind_CONSTRAINT = 225,
  Kind_LINQ = 226,
  Kind_FROM = 227,
  Kind_WHERE = 228,
  Kind_SELECT = 229,
  Kind_LET = 230,
  Kind_ORDERBY = 231,
  Kind_JOIN = 232,
  Kind_GROUP = 233,
  Kind_IN = 234,
  Kind_ON = 235,
  Kind_EQUALS = 236,
  Kind_BY = 237,
  Kind_INTO = 238,
  Kind_EMPTY = 239,
  Kind_EMPTY_STMT = 240,
  Kind_RECEIVER = 241,
  Kind_MESSAGE = 242,
  Kind_SELECTOR = 243,
  Kind_PROTOCOL_LIST = 244,
  Kind_CATEGORY = 245,
  Kind_PROTOCOL = 246,
  Kind_REQUIRED_DEFAULT = 247,
  Kind_REQUIRED = 248,
  Kind_OPTIONAL = 249,
  Kind_ATTRIBUTE_LIST = 250,
  Kind_SYNTHESIZE = 251,
  Kind_DYNAMIC = 252,
  Kind_ENCODE = 253,
  Kind_AUTORELEASEPOOL = 254,
  Kind_COMPATIBILITY_ALIAS = 255,
  Kind_NIL = 256,
  Kind_CLASS_INTERFACE = 257,
  Kind_CLASS_IMPLEMENTATION = 258,
  Kind_PROTOCOL_DECLARATION = 259,
  Kind_CAST = 260,
  Kind_CONST_CAST = 261,
  Kind_DYNAMIC_CAST = 262,
  Kind_REINTERPRET_CAST = 263,
  Kind_STATIC_CAST = 264,
  Kind_POSITION = 265,
  Kind_CUDA_ARGUMENT_LIST = 266,
  Kind_OMP_DIRECTIVE = 267,
  Kind_OMP_NAME = 268,
  Kind_OMP_CLAUSE = 269,
  Kind_OMP_ARGUMENT_LIST = 270,
  Kind_OMP_ARGUMENT = 271,
  Kind_OMP_EXPRESSION = 272,
  Kind_END_ELEMENT_TOKEN = 273,
  Kind_MAIN = 274,
  Kind_BREAK = 275,
  Kind_CONTINUE = 276,
  Kind_WHILE = 277,
  Kind_DO = 278,
  Kind_FOR = 279,
  Kind_IF = 280,
  Kind_GOTO = 281,
  Kind_VISUAL_CXX_ASM = 282,
  Kind_SIZEOF = 283,
  Kind_AUTO = 284,
  Kind_REGISTER = 285,
  Kind_RESTRICT = 286,
  Kind_IMAGINARY = 287,
  Kind_NORETURN = 288,
  Kind_STATIC_ASSERT = 289,
  Kind_CRESTRICT = 290,
  Kind_CXX_TRY = 291,
  Kind_CXX_CATCH = 292,
  Kind_CXX_CLASS = 293,
  Kind_CONSTEXPR = 294,
  Kind_THREAD_LOCAL = 295,
  Kind_NULLPTR = 296,
  Kind_VOID = 297,
  Kind_RETURN = 298,
  Kind_INCLUDE = 299,
  Kind_DEFINE = 300,
  Kind_ELIF = 301,
  Kind_ENDIF = 302,
  Kind_ERRORPREC = 303,
  Kind_WARNING = 304,
  Kind_IFDEF = 305,
  Kind_IFNDEF = 306,
  Kind_LINE = 307,
  Kind_PRAGMA = 308,
  Kind_UNDEF = 309,
  Kind_INLINE = 310,
  Kind_MACRO_TYPE_NAME = 311,
  Kind_MACRO_CASE = 312,
  Kind_MACRO_LABEL = 313,
  Kind_SPECIFIER = 314,
  Kind_TRY = 315,
  Kind_CATCH = 316,
  Kind_THROW = 317,
  Kind_THROWS = 318,
  Kind_PUBLIC = 319,
  Kind_PRIVATE = 320,
  Kind_PROTECTED = 321,
  Kind_VIRTUAL = 322,
  Kind_EXPLICIT = 323,
  Kind_FOREVER = 324,
  Kind_SIGNAL = 325,
  Kind_EMIT = 326,
  Kind_NEW = 327,
  Kind_DELETE = 328,
  Kind_STATIC = 329,
  Kind_CONST = 330,
  Kind_MUTABLE = 331,
  Kind_VOLATILE = 332,
  Kind_TRANSIENT = 333,
  Kind_FINALLY = 334,
  Kind_FINAL = 335,
  Kind_ABSTRACT = 336,
  Kind_SUPER = 337,
  Kind_SYNCHRONIZED = 338,
  Kind_NATIVE = 339,
  Kind_STRICTFP = 340,
  Kind_NULLLITERAL = 341,
  Kind_ASSERT = 342,
  Kind_FOREACH = 343,
  Kind_REF = 344,
  Kind_OUT = 345,
  Kind_LOCK = 346,
  Kind_IS = 347,
  Kind_INTERNAL = 348,
  Kind_SEALED = 349,
  Kind_OVERRIDE = 350,
  Kind_IMPLICIT = 351,
  Kind_STACKALLOC = 352,
  Kind_AS = 353,
  Kind_DELEGATE = 354,
  Kind_FIXED = 355,
  Kind_CHECKED = 356,
  Kind_UNCHECKED = 357,
  Kind_REGION = 358,
  Kind_ENDREGION = 359,
  Kind_UNSAFE = 360,
  Kind_READONLY = 361,
  Kind_GET = 362,
  Kind_SET = 363,
  Kind_ADD = 364,
  Kind_REMOVE = 365,
  Kind_YIELD = 366,
  Kind_PARTIAL = 367,
  Kind_AWAIT = 368,
  Kind_ASYNC = 369,
  Kind_THIS = 370,
  Kind_PARAMS = 371,
  Kind_ALIAS = 372,
  Kind_ASCENDING = 373,
  Kind_DESCENDING = 374,
  Kind_ATINTERFACE = 375,
  Kind_ATIMPLEMENTATION = 376,
  Kind_ATEND = 377,
  Kind_ATPROTOCOL = 378,
  Kind_ATREQUIRED = 379,
  Kind_ATOPTIONAL = 380,
  Kind_ATCLASS = 381,
  Kind_WEAK = 382,
  Kind_STRONG = 383,
  Kind_OMP_OMP = 384,
  Kind_SPECIAL_CHARS = 385,
  Kind_MIN = Kind_UNIT_KIND,
  Kind_MAX = Kind_SPECIAL_CHARS
};

inline const char **EnumNamesKind() {
  static const char *names[] = {
    "UNIT_KIND",
    "DECL",
    "DECL_STMT",
    "INIT",
    "EXPR",
    "EXPR_STMT",
    "COMMENT",
    "CALL",
    "CONTROL",
    "INCR",
    "NONE",
    "VARIABLE",
    "FUNCTION",
    "FUNCTION_DECL",
    "CONSTRUCTOR",
    "CONSTRUCTOR_DECL",
    "DESTRUCTOR",
    "DESTRUCTOR_DECL",
    "MACRO",
    "SINGLE_MACRO",
    "NULLOPERATOR",
    "ENUM_DEFN",
    "ENUM_DECL",
    "GLOBAL_ATTRIBUTE",
    "PROPERTY_ACCESSOR",
    "PROPERTY_ACCESSOR_DECL",
    "EXPRESSION",
    "CLASS_DEFN",
    "CLASS_DECL",
    "UNION_DEFN",
    "UNION_DECL",
    "STRUCT_DEFN",
    "STRUCT_DECL",
    "INTERFACE_DEFN",
    "INTERFACE_DECL",
    "ACCESS_REGION",
    "USING",
    "OPERATOR_FUNCTION",
    "OPERATOR_FUNCTION_DECL",
    "EVENT",
    "PROPERTY",
    "ANNOTATION_DEFN",
    "GLOBAL_TEMPLATE",
    "UNIT",
    "TART_ELEMENT_TOKEN",
    "NOP",
    "STRING",
    "CHAR",
    "LITERAL",
    "BOOLEAN",
    "NULL",
    "COMPLEX",
    "OPERATOR",
    "MODIFIER",
    "NAME",
    "ONAME",
    "CNAME",
    "TYPE",
    "TYPEPREV",
    "CONDITION",
    "BLOCK",
    "PSEUDO_BLOCK",
    "INDEX",
    "ENUM",
    "ENUM_DECLARATION",
    "IF_STATEMENT",
    "TERNARY",
    "THEN",
    "ELSE",
    "ELSEIF",
    "WHILE_STATEMENT",
    "DO_STATEMENT",
    "FOR_STATEMENT",
    "FOREACH_STATEMENT",
    "FOR_CONTROL",
    "FOR_INITIALIZATION",
    "FOR_CONDITION",
    "FOR_INCREMENT",
    "FOR_LIKE_CONTROL",
    "EXPRESSION_STATEMENT",
    "FUNCTION_CALL",
    "DECLARATION_STATEMENT",
    "DECLARATION",
    "DECLARATION_INITIALIZATION",
    "DECLARATION_RANGE",
    "RANGE",
    "GOTO_STATEMENT",
    "CONTINUE_STATEMENT",
    "BREAK_STATEMENT",
    "LABEL_STATEMENT",
    "LABEL",
    "SWITCH",
    "CASE",
    "DEFAULT",
    "FUNCTION_DEFINITION",
    "FUNCTION_DECLARATION",
    "LAMBDA",
    "FUNCTION_LAMBDA",
    "FUNCTION_SPECIFIER",
    "RETURN_STATEMENT",
    "PARAMETER_LIST",
    "PARAMETER",
    "KRPARAMETER_LIST",
    "KRPARAMETER",
    "ARGUMENT_LIST",
    "ARGUMENT",
    "PSEUDO_PARAMETER_LIST",
    "INDEXER_PARAMETER_LIST",
    "CLASS",
    "CLASS_DECLARATION",
    "STRUCT",
    "STRUCT_DECLARATION",
    "UNION",
    "UNION_DECLARATION",
    "DERIVATION_LIST",
    "PUBLIC_ACCESS",
    "PUBLIC_ACCESS_DEFAULT",
    "PRIVATE_ACCESS",
    "PRIVATE_ACCESS_DEFAULT",
    "PROTECTED_ACCESS",
    "PROTECTED_ACCESS_DEFAULT",
    "MEMBER_INIT_LIST",
    "MEMBER_INITIALIZATION_LIST",
    "MEMBER_INITIALIZATION",
    "CONSTRUCTOR_DEFINITION",
    "CONSTRUCTOR_DECLARATION",
    "DESTRUCTOR_DEFINITION",
    "DESTRUCTOR_DECLARATION",
    "FRIEND",
    "CLASS_SPECIFIER",
    "TRY_BLOCK",
    "CATCH_BLOCK",
    "FINALLY_BLOCK",
    "THROW_STATEMENT",
    "THROW_SPECIFIER",
    "THROW_SPECIFIER_JAVA",
    "TEMPLATE",
    "GENERIC_ARGUMENT",
    "GENERIC_ARGUMENT_LIST",
    "TEMPLATE_PARAMETER",
    "TEMPLATE_PARAMETER_LIST",
    "GENERIC_PARAMETER",
    "GENERIC_PARAMETER_LIST",
    "TYPEDEF",
    "ASM",
    "MACRO_CALL",
    "SIZEOF_CALL",
    "EXTERN",
    "NAMESPACE",
    "USING_DIRECTIVE",
    "DIRECTIVE",
    "ATOMIC",
    "STATIC_ASSERT_STATEMENT",
    "GENERIC_SELECTION",
    "GENERIC_SELECTOR",
    "GENERIC_ASSOCIATION_LIST",
    "GENERIC_ASSOCIATION",
    "ALIGNAS",
    "DECLTYPE",
    "CAPTURE",
    "LAMBDA_CAPTURE",
    "NOEXCEPT",
    "TYPENAME",
    "ALIGNOF",
    "TYPEID",
    "SIZEOF_PACK",
    "ENUM_CLASS",
    "ENUM_CLASS_DECLARATION",
    "REF_QUALIFIER",
    "SIGNAL_ACCESS",
    "FOREVER_STATEMENT",
    "EMIT_STATEMENT",
    "CPP_DIRECTIVE",
    "CPP_FILENAME",
    "FILE",
    "NUMBER",
    "CPP_NUMBER",
    "CPP_LITERAL",
    "CPP_MACRO_DEFN",
    "CPP_MACRO_VALUE",
    "ERROR",
    "CPP_ERROR",
    "CPP_WARNING",
    "CPP_PRAGMA",
    "CPP_INCLUDE",
    "CPP_DEFINE",
    "CPP_UNDEF",
    "CPP_LINE",
    "CPP_IF",
    "CPP_IFDEF",
    "CPP_IFNDEF",
    "CPP_THEN",
    "CPP_ELSE",
    "CPP_ELIF",
    "CPP_EMPTY",
    "CPP_REGION",
    "CPP_ENDREGION",
    "USING_STMT",
    "ESCAPE",
    "VALUE",
    "CPP_IMPORT",
    "CPP_ENDIF",
    "MARKER",
    "ERROR_PARSE",
    "ERROR_MODE",
    "IMPLEMENTS",
    "EXTENDS",
    "IMPORT",
    "PACKAGE",
    "ASSERT_STATEMENT",
    "INTERFACE",
    "INTERFACE_DECLARATION",
    "SYNCHRONIZED_STATEMENT",
    "ANNOTATION",
    "STATIC_BLOCK",
    "CHECKED_STATEMENT",
    "UNCHECKED_STATEMENT",
    "ATTRIBUTE",
    "TARGET",
    "UNSAFE_STATEMENT",
    "LOCK_STATEMENT",
    "FIXED_STATEMENT",
    "TYPEOF",
    "USING_STATEMENT",
    "FUNCTION_DELEGATE",
    "CONSTRAINT",
    "LINQ",
    "FROM",
    "WHERE",
    "SELECT",
    "LET",
    "ORDERBY",
    "JOIN",
    "GROUP",
    "IN",
    "ON",
    "EQUALS",
    "BY",
    "INTO",
    "EMPTY",
    "EMPTY_STMT",
    "RECEIVER",
    "MESSAGE",
    "SELECTOR",
    "PROTOCOL_LIST",
    "CATEGORY",
    "PROTOCOL",
    "REQUIRED_DEFAULT",
    "REQUIRED",
    "OPTIONAL",
    "ATTRIBUTE_LIST",
    "SYNTHESIZE",
    "DYNAMIC",
    "ENCODE",
    "AUTORELEASEPOOL",
    "COMPATIBILITY_ALIAS",
    "NIL",
    "CLASS_INTERFACE",
    "CLASS_IMPLEMENTATION",
    "PROTOCOL_DECLARATION",
    "CAST",
    "CONST_CAST",
    "DYNAMIC_CAST",
    "REINTERPRET_CAST",
    "STATIC_CAST",
    "POSITION",
    "CUDA_ARGUMENT_LIST",
    "OMP_DIRECTIVE",
    "OMP_NAME",
    "OMP_CLAUSE",
    "OMP_ARGUMENT_LIST",
    "OMP_ARGUMENT",
    "OMP_EXPRESSION",
    "END_ELEMENT_TOKEN",
    "MAIN",
    "BREAK",
    "CONTINUE",
    "WHILE",
    "DO",
    "FOR",
    "IF",
    "GOTO",
    "VISUAL_CXX_ASM",
    "SIZEOF",
    "AUTO",
    "REGISTER",
    "RESTRICT",
    "IMAGINARY",
    "NORETURN",
    "STATIC_ASSERT",
    "CRESTRICT",
    "CXX_TRY",
    "CXX_CATCH",
    "CXX_CLASS",
    "CONSTEXPR",
    "THREAD_LOCAL",
    "NULLPTR",
    "VOID",
    "RETURN",
    "INCLUDE",
    "DEFINE",
    "ELIF",
    "ENDIF",
    "ERRORPREC",
    "WARNING",
    "IFDEF",
    "IFNDEF",
    "LINE",
    "PRAGMA",
    "UNDEF",
    "INLINE",
    "MACRO_TYPE_NAME",
    "MACRO_CASE",
    "MACRO_LABEL",
    "SPECIFIER",
    "TRY",
    "CATCH",
    "THROW",
    "THROWS",
    "PUBLIC",
    "PRIVATE",
    "PROTECTED",
    "VIRTUAL",
    "EXPLICIT",
    "FOREVER",
    "SIGNAL",
    "EMIT",
    "NEW",
    "DELETE",
    "STATIC",
    "CONST",
    "MUTABLE",
    "VOLATILE",
    "TRANSIENT",
    "FINALLY",
    "FINAL",
    "ABSTRACT",
    "SUPER",
    "SYNCHRONIZED",
    "NATIVE",
    "STRICTFP",
    "NULLLITERAL",
    "ASSERT",
    "FOREACH",
    "REF",
    "OUT",
    "LOCK",
    "IS",
    "INTERNAL",
    "SEALED",
    "OVERRIDE",
    "IMPLICIT",
    "STACKALLOC",
    "AS",
    "DELEGATE",
    "FIXED",
    "CHECKED",
    "UNCHECKED",
    "REGION",
    "ENDREGION",
    "UNSAFE",
    "READONLY",
    "GET",
    "SET",
    "ADD",
    "REMOVE",
    "YIELD",
    "PARTIAL",
    "AWAIT",
    "ASYNC",
    "THIS",
    "PARAMS",
    "ALIAS",
    "ASCENDING",
    "DESCENDING",
    "ATINTERFACE",
    "ATIMPLEMENTATION",
    "ATEND",
    "ATPROTOCOL",
    "ATREQUIRED",
    "ATOPTIONAL",
    "ATCLASS",
    "WEAK",
    "STRONG",
    "OMP_OMP",
    "SPECIAL_CHARS",
    nullptr
  };
  return names;
}

inline const char *EnumNameKind(Kind e) {
  const size_t index = static_cast<int>(e);
  return EnumNamesKind()[index];
}

namespace _Unit {

enum LanguageType {
  LanguageType_ALL = 0,
  LanguageType_OO = 1,
  LanguageType_CXX = 2,
  LanguageType_C = 3,
  LanguageType_C_FAMILY = 4,
  LanguageType_JAVA = 5,
  LanguageType_CSHARP = 6,
  LanguageType_OBJECTIVE_C = 7,
  LanguageType_MIN = LanguageType_ALL,
  LanguageType_MAX = LanguageType_OBJECTIVE_C
};

inline const char **EnumNamesLanguageType() {
  static const char *names[] = {
    "ALL",
    "OO",
    "CXX",
    "C",
    "C_FAMILY",
    "JAVA",
    "CSHARP",
    "OBJECTIVE_C",
    nullptr
  };
  return names;
}

inline const char *EnumNameLanguageType(LanguageType e) {
  const size_t index = static_cast<int>(e);
  return EnumNamesLanguageType()[index];
}

}  // namespace _Unit

namespace _Literal {

enum LiteralType {
  LiteralType_number_type = 0,
  LiteralType_char_type = 1,
  LiteralType_string_type = 2,
  LiteralType_boolean_type = 3,
  LiteralType_null_type = 4,
  LiteralType_MIN = LiteralType_number_type,
  LiteralType_MAX = LiteralType_null_type
};

inline const char **EnumNamesLiteralType() {
  static const char *names[] = {
    "number_type",
    "char_type",
    "string_type",
    "boolean_type",
    "null_type",
    nullptr
  };
  return names;
}

inline const char *EnumNameLiteralType(LiteralType e) {
  const size_t index = static_cast<int>(e);
  return EnumNamesLiteralType()[index];
}

}  // namespace _Literal
}  // namespace _Element

struct Element FLATBUFFERS_FINAL_CLASS : private flatbuffers::Table {
  enum {
    VT_KIND = 4,
    VT_TEXT = 6,
    VT_TAIL = 8,
    VT_CHILD = 10,
    VT_EXTRA = 12
  };
  int32_t kind() const {
    return GetField<int32_t>(VT_KIND, 0);
  }
  const flatbuffers::String *text() const {
    return GetPointer<const flatbuffers::String *>(VT_TEXT);
  }
  const flatbuffers::String *tail() const {
    return GetPointer<const flatbuffers::String *>(VT_TAIL);
  }
  const flatbuffers::Vector<flatbuffers::Offset<Element>> *child() const {
    return GetPointer<const flatbuffers::Vector<flatbuffers::Offset<Element>> *>(VT_CHILD);
  }
  const _fast::_Element::Anonymous0 *extra() const {
    return GetPointer<const _fast::_Element::Anonymous0 *>(VT_EXTRA);
  }
  bool Verify(flatbuffers::Verifier &verifier) const {
    return VerifyTableStart(verifier) &&
           VerifyField<int32_t>(verifier, VT_KIND) &&
           VerifyField<flatbuffers::uoffset_t>(verifier, VT_TEXT) &&
           verifier.Verify(text()) &&
           VerifyField<flatbuffers::uoffset_t>(verifier, VT_TAIL) &&
           verifier.Verify(tail()) &&
           VerifyField<flatbuffers::uoffset_t>(verifier, VT_CHILD) &&
           verifier.Verify(child()) &&
           verifier.VerifyVectorOfTables(child()) &&
           VerifyField<flatbuffers::uoffset_t>(verifier, VT_EXTRA) &&
           verifier.VerifyTable(extra()) &&
           verifier.EndTable();
  }
};

struct ElementBuilder {
  flatbuffers::FlatBufferBuilder &fbb_;
  flatbuffers::uoffset_t start_;
  void add_kind(int32_t kind) {
    fbb_.AddElement<int32_t>(Element::VT_KIND, kind, 0);
  }
  void add_text(flatbuffers::Offset<flatbuffers::String> text) {
    fbb_.AddOffset(Element::VT_TEXT, text);
  }
  void add_tail(flatbuffers::Offset<flatbuffers::String> tail) {
    fbb_.AddOffset(Element::VT_TAIL, tail);
  }
  void add_child(flatbuffers::Offset<flatbuffers::Vector<flatbuffers::Offset<Element>>> child) {
    fbb_.AddOffset(Element::VT_CHILD, child);
  }
  void add_extra(flatbuffers::Offset<_fast::_Element::Anonymous0> extra) {
    fbb_.AddOffset(Element::VT_EXTRA, extra);
  }
  ElementBuilder(flatbuffers::FlatBufferBuilder &_fbb)
        : fbb_(_fbb) {
    start_ = fbb_.StartTable();
  }
  ElementBuilder &operator=(const ElementBuilder &);
  flatbuffers::Offset<Element> Finish() {
    const auto end = fbb_.EndTable(start_, 5);
    auto o = flatbuffers::Offset<Element>(end);
    return o;
  }
};

inline flatbuffers::Offset<Element> CreateElement(
    flatbuffers::FlatBufferBuilder &_fbb,
    int32_t kind = 0,
    flatbuffers::Offset<flatbuffers::String> text = 0,
    flatbuffers::Offset<flatbuffers::String> tail = 0,
    flatbuffers::Offset<flatbuffers::Vector<flatbuffers::Offset<Element>>> child = 0,
    flatbuffers::Offset<_fast::_Element::Anonymous0> extra = 0) {
  ElementBuilder builder_(_fbb);
  builder_.add_extra(extra);
  builder_.add_child(child);
  builder_.add_tail(tail);
  builder_.add_text(text);
  builder_.add_kind(kind);
  return builder_.Finish();
}

inline flatbuffers::Offset<Element> CreateElementDirect(
    flatbuffers::FlatBufferBuilder &_fbb,
    int32_t kind = 0,
    const char *text = nullptr,
    const char *tail = nullptr,
    const std::vector<flatbuffers::Offset<Element>> *child = nullptr,
    flatbuffers::Offset<_fast::_Element::Anonymous0> extra = 0) {
  return _fast::CreateElement(
      _fbb,
      kind,
      text ? _fbb.CreateString(text) : 0,
      tail ? _fbb.CreateString(tail) : 0,
      child ? _fbb.CreateVector<flatbuffers::Offset<Element>>(*child) : 0,
      extra);
}

namespace _Element {

struct Anonymous0 FLATBUFFERS_FINAL_CLASS : private flatbuffers::Table {
  enum {
    VT_UNIT = 4,
    VT_LITERAL = 6
  };
  const Unit *unit() const {
    return GetPointer<const Unit *>(VT_UNIT);
  }
  const Literal *literal() const {
    return GetPointer<const Literal *>(VT_LITERAL);
  }
  bool Verify(flatbuffers::Verifier &verifier) const {
    return VerifyTableStart(verifier) &&
           VerifyField<flatbuffers::uoffset_t>(verifier, VT_UNIT) &&
           verifier.VerifyTable(unit()) &&
           VerifyField<flatbuffers::uoffset_t>(verifier, VT_LITERAL) &&
           verifier.VerifyTable(literal()) &&
           verifier.EndTable();
  }
};

struct Anonymous0Builder {
  flatbuffers::FlatBufferBuilder &fbb_;
  flatbuffers::uoffset_t start_;
  void add_unit(flatbuffers::Offset<Unit> unit) {
    fbb_.AddOffset(Anonymous0::VT_UNIT, unit);
  }
  void add_literal(flatbuffers::Offset<Literal> literal) {
    fbb_.AddOffset(Anonymous0::VT_LITERAL, literal);
  }
  Anonymous0Builder(flatbuffers::FlatBufferBuilder &_fbb)
        : fbb_(_fbb) {
    start_ = fbb_.StartTable();
  }
  Anonymous0Builder &operator=(const Anonymous0Builder &);
  flatbuffers::Offset<Anonymous0> Finish() {
    const auto end = fbb_.EndTable(start_, 2);
    auto o = flatbuffers::Offset<Anonymous0>(end);
    return o;
  }
};

inline flatbuffers::Offset<Anonymous0> CreateAnonymous0(
    flatbuffers::FlatBufferBuilder &_fbb,
    flatbuffers::Offset<Unit> unit = 0,
    flatbuffers::Offset<Literal> literal = 0) {
  Anonymous0Builder builder_(_fbb);
  builder_.add_literal(literal);
  builder_.add_unit(unit);
  return builder_.Finish();
}

struct Unit FLATBUFFERS_FINAL_CLASS : private flatbuffers::Table {
  enum {
    VT_FILENAME = 4,
    VT_REVISION = 6,
    VT_LANGUAGE = 8,
    VT_ITEM = 10
  };
  const flatbuffers::String *filename() const {
    return GetPointer<const flatbuffers::String *>(VT_FILENAME);
  }
  const flatbuffers::String *revision() const {
    return GetPointer<const flatbuffers::String *>(VT_REVISION);
  }
  int32_t language() const {
    return GetField<int32_t>(VT_LANGUAGE, 0);
  }
  int32_t item() const {
    return GetField<int32_t>(VT_ITEM, 0);
  }
  bool Verify(flatbuffers::Verifier &verifier) const {
    return VerifyTableStart(verifier) &&
           VerifyField<flatbuffers::uoffset_t>(verifier, VT_FILENAME) &&
           verifier.Verify(filename()) &&
           VerifyField<flatbuffers::uoffset_t>(verifier, VT_REVISION) &&
           verifier.Verify(revision()) &&
           VerifyField<int32_t>(verifier, VT_LANGUAGE) &&
           VerifyField<int32_t>(verifier, VT_ITEM) &&
           verifier.EndTable();
  }
};

struct UnitBuilder {
  flatbuffers::FlatBufferBuilder &fbb_;
  flatbuffers::uoffset_t start_;
  void add_filename(flatbuffers::Offset<flatbuffers::String> filename) {
    fbb_.AddOffset(Unit::VT_FILENAME, filename);
  }
  void add_revision(flatbuffers::Offset<flatbuffers::String> revision) {
    fbb_.AddOffset(Unit::VT_REVISION, revision);
  }
  void add_language(int32_t language) {
    fbb_.AddElement<int32_t>(Unit::VT_LANGUAGE, language, 0);
  }
  void add_item(int32_t item) {
    fbb_.AddElement<int32_t>(Unit::VT_ITEM, item, 0);
  }
  UnitBuilder(flatbuffers::FlatBufferBuilder &_fbb)
        : fbb_(_fbb) {
    start_ = fbb_.StartTable();
  }
  UnitBuilder &operator=(const UnitBuilder &);
  flatbuffers::Offset<Unit> Finish() {
    const auto end = fbb_.EndTable(start_, 4);
    auto o = flatbuffers::Offset<Unit>(end);
    return o;
  }
};

inline flatbuffers::Offset<Unit> CreateUnit(
    flatbuffers::FlatBufferBuilder &_fbb,
    flatbuffers::Offset<flatbuffers::String> filename = 0,
    flatbuffers::Offset<flatbuffers::String> revision = 0,
    int32_t language = 0,
    int32_t item = 0) {
  UnitBuilder builder_(_fbb);
  builder_.add_item(item);
  builder_.add_language(language);
  builder_.add_revision(revision);
  builder_.add_filename(filename);
  return builder_.Finish();
}

inline flatbuffers::Offset<Unit> CreateUnitDirect(
    flatbuffers::FlatBufferBuilder &_fbb,
    const char *filename = nullptr,
    const char *revision = nullptr,
    int32_t language = 0,
    int32_t item = 0) {
  return _fast::_Element::CreateUnit(
      _fbb,
      filename ? _fbb.CreateString(filename) : 0,
      revision ? _fbb.CreateString(revision) : 0,
      language,
      item);
}

struct Literal FLATBUFFERS_FINAL_CLASS : private flatbuffers::Table {
  enum {
    VT_TYPE = 4
  };
  int32_t type() const {
    return GetField<int32_t>(VT_TYPE, 0);
  }
  bool Verify(flatbuffers::Verifier &verifier) const {
    return VerifyTableStart(verifier) &&
           VerifyField<int32_t>(verifier, VT_TYPE) &&
           verifier.EndTable();
  }
};

struct LiteralBuilder {
  flatbuffers::FlatBufferBuilder &fbb_;
  flatbuffers::uoffset_t start_;
  void add_type(int32_t type) {
    fbb_.AddElement<int32_t>(Literal::VT_TYPE, type, 0);
  }
  LiteralBuilder(flatbuffers::FlatBufferBuilder &_fbb)
        : fbb_(_fbb) {
    start_ = fbb_.StartTable();
  }
  LiteralBuilder &operator=(const LiteralBuilder &);
  flatbuffers::Offset<Literal> Finish() {
    const auto end = fbb_.EndTable(start_, 1);
    auto o = flatbuffers::Offset<Literal>(end);
    return o;
  }
};

inline flatbuffers::Offset<Literal> CreateLiteral(
    flatbuffers::FlatBufferBuilder &_fbb,
    int32_t type = 0) {
  LiteralBuilder builder_(_fbb);
  builder_.add_type(type);
  return builder_.Finish();
}

}  // namespace _Element

namespace _Element {

}  // namespace _Element
}  // namespace _fast

#endif  // FLATBUFFERS_GENERATED_FAST__FAST__ELEMENT_H_