; Variables

(identifier) @variable.other.zig

; Parameters

(parameter
  name: (identifier) @variable.parameter.zig)

; Types

(parameter
  type: (identifier) @support.type.zig)

((identifier) @support.type.zig
  )

(variable_declaration
  (identifier) @support.type.zig
  "="
  [
    (struct_declaration)
    (enum_declaration)
    (union_declaration)
    (opaque_declaration)
  ])

[
  (builtin_type)
  "anyframe"
] @support.type.builtin.zig

; Constants

((identifier) @constant.other.zig
  )

[
  "null"
  "unreachable"
  "undefined"
] @constant.language.zig

(field_expression
  .
  member: (identifier) @constant.other.zig)

(enum_declaration
  (container_field
    type: (identifier) @constant.other.zig))

; Labels

(block_label (identifier) @entity.name.label.zig)

(break_label (identifier) @entity.name.label.zig)

; Fields

(field_initializer
  .
  (identifier) @variable.other.member.zig)

(field_expression
  (_)
  member: (identifier) @variable.other.member.zig)

(container_field
  name: (identifier) @variable.other.member.zig)

(initializer_list
  (assignment_expression
      left: (field_expression
              .
              member: (identifier) @variable.other.member.zig)))

; Functions

(builtin_identifier) @support.function.builtin.zig

(call_expression
  function: (identifier) @support.other.function.zig)

(call_expression
  function: (field_expression
    member: (identifier) @support.other.function.zig))

(function_declaration
  name: (identifier) @entity.name.function.zig)

; Modules

(variable_declaration
  (identifier) @entity.name.namespace.zig
  (builtin_function
    (builtin_identifier) @keyword.control.import.zig
    (#any-of? @keyword.control.import.zig "@import" "@cImport")))

; Builtins

[
  "c"
  "..."
] @variable.language.zig

((identifier) @variable.language.zig
  (#eq? @variable.language.zig "_"))

(calling_convention
  (identifier) @variable.language.zig)

; Keywords

[
  "asm"
  "defer"
  "errdefer"
  "test"
  "error"
  "const"
  "var"
] @keyword.control.zig

[
  "struct"
  "union"
  "enum"
  "opaque"
] @storage.type.zig

[
  "async"
  "await"
  "suspend"
  "nosuspend"
  "resume"
] @keyword.control.zig

"fn" @storage.type.function.zig

[
  "and"
  "or"
  "orelse"
] @keyword.operator.word.zig

"return" @keyword.control.return.zig

[
  "if"
  "else"
  "switch"
] @keyword.control.conditional.zig

[
  "for"
  "while"
  "break"
  "continue"
] @keyword.control.loop.zig

[
  "usingnamespace"
  "export"
] @keyword.control.import.zig

[
  "try"
  "catch"
] @keyword.control.exception.zig

[
  "volatile"
  "allowzero"
  "noalias"
  "addrspace"
  "align"
  "callconv"
  "linksection"
  "pub"
  "inline"
  "noinline"
  "extern"
  "comptime"
  "packed"
  "threadlocal"
] @storage.modifier.zig

; Operator

[
  "="
  "*="
  "*%="
  "*|="
  "/="
  "%="
  "+="
  "+%="
  "+|="
  "-="
  "-%="
  "-|="
  "<<="
  "<<|="
  ">>="
  "&="
  "^="
  "|="
  "!"
  "~"
  "-"
  "-%"
  "&"
  "=="
  "!="
  ">"
  ">="
  "<="
  "<"
  "&"
  "^"
  "|"
  "<<"
  ">>"
  "<<|"
  "+"
  "++"
  "+%"
  "-%"
  "+|"
  "-|"
  "*"
  "/"
  "%"
  "**"
  "*%"
  "*|"
  "||"
  ".*"
  ".?"
  "?"
  ".."
] @keyword.operator.zig

; Literals

(character) @string.quoted.single.zig

([
  (string)
  (multiline_string)
] @string.quoted.double.zig
  )

(integer) @constant.numeric.zig

(float) @constant.numeric.float.zig

(boolean) @constant.language.boolean.zig

(escape_sequence) @constant.character.escape.zig

; Punctuation

"[" @punctuation.definition.array.begin.bracket.square.zig
"]" @punctuation.definition.array.end.bracket.square.zig
"(" @punctuation.definition.arguments.begin.bracket.round.zig
")" @punctuation.definition.arguments.end.bracket.round.zig
"{" @punctuation.definition.block.begin.bracket.curly.zig
"}" @punctuation.definition.block.end.bracket.curly.zig

";" @punctuation.terminator.statement.zig
"." @punctuation.separator.property.zig
"," @punctuation.separator.comma.zig
":" @punctuation.separator.type.zig
"=>" @punctuation.separator.switch-case.zig
"->" @punctuation.separator.return-type.zig

(payload "|" @punctuation.bracket)

; Comments

(comment) @comment.line.zig @_IGNORE_.spell

((comment) @comment.block.documentation.zig
  )
