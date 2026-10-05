(function_declaration name: (identifier) @name) @definition.function
(variable_declaration . (identifier) @name (struct_declaration)) @definition.struct
(variable_declaration . (identifier) @name (enum_declaration)) @definition.enum
(variable_declaration . (identifier) @name (union_declaration)) @definition.union
(variable_declaration . (identifier) @name (opaque_declaration)) @definition.type
(variable_declaration . (identifier) @name (error_set_declaration)) @definition.type
; The fallback emits no enclosing container after rejecting a container name.
(variable_declaration . (identifier) @name
  (#is-not? test.typeAt "parent.lastNamedChild struct_declaration enum_declaration union_declaration opaque_declaration error_set_declaration")
  (#not-eq? @name "_")
  (#set! symbol.tag "variable"))
(container_field name: (identifier) @name
  (#is-not? test.typeAt "parent.parent enum_declaration")
  (#set! symbol.tag "field"))
(enum_declaration (container_field name: (identifier) @name) @definition.constant)
(error_set_declaration (identifier) @name
  (#set! symbol.tag "constant"))
(test_declaration (string (string_content) @name)) @definition.test
