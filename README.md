# language-zig

Zig language support.

## Features

- **Grammars**: provides Tree-sitter grammars, built from [tree-sitter-zig](https://github.com/tree-sitter-grammars/tree-sitter-zig).
- **Syntax highlighting**: full tree-sitter grammar coverage for Zig files.
- **Folding**: folds blocks from the parse tree rather than by indentation.

## Installation

To install `language-zig` search for _language-zig_ in the Install pane of the Lumine settings or run `lumine --install lumine-code/language-zig`.

## Services

- **hyperlink.injection** (`^1.0.0`): consumed to highlight URLs inside Zig files as clickable links.
- **todo.injection** (`^1.0.0`): consumed to highlight `TODO`-style markers inside comments.

## Contributing

Got ideas to make this package better, found a bug, or want to help add new features? Just drop your thoughts on GitHub. Any feedback is welcome!
