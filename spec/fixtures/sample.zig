// Assertions live in the comments: `<- scope` checks the marker's own column
// on the previous non-comment line, `^ scope` checks the caret's. Scopes
// match by prefix, so the trailing `.zig` segment is left off.

pub fn main() void {
//  ^ storage.type.function
//         ^ punctuation.definition.arguments.begin.bracket.round
//                 ^ punctuation.definition.block.begin.bracket.curly

    const x = 1;
//            ^ constant.numeric
//             ^ punctuation.terminator.statement

}
// <- punctuation.definition.block.end.bracket.curly

// a comment
// <- comment
