; Only explicit delimiters change indentation; incomplete expressions do not.
["{" "[" "("] @indent
["}" "]" ")"] @dedent

; Reindent code without rewriting whitespace that belongs to multiline text.
([(string) (comment)] @preserve
  (#is? indent.reindent true)
  (#is-not? indent.matchesCurrentRow startPosition)
  (#set! indent.force true))

; A Zig multiline string starts on its own continuation line.
((multiline_string) @preserve
  (#is? indent.reindent true)
  (#set! indent.force true))
