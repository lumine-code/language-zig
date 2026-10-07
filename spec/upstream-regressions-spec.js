describe("Zig upstream query regressions", () => {
  let editor;

  beforeEach(async () => {
    await lumine.packages.activatePackage("language-zig");
    editor = await lumine.workspace.open();
    editor.setGrammar(lumine.grammars.grammarForScopeName("source.zig"));
  });

  afterEach(() => editor?.destroy());

  it("folds a multiline function call", async () => {
    editor.setText("const value = create(\n    first,\n    second,\n);\n");
    expect(await editor.whenGrammarSettled()).toBe(true);
    editor.foldBufferRow(0);
    expect(editor.isFoldedAtBufferRow(0)).toBe(true);
  });

  it("highlights captured payload names as parameters", async () => {
    editor.setText("fn f(value: ?u32) void { if (value) |item| { _ = item; } }\n");
    expect(await editor.whenGrammarSettled()).toBe(true);
    const column = editor.lineTextForBufferRow(0).indexOf("item");
    expect(editor.scopeDescriptorForBufferPosition([0, column]).getScopesArray()).toContain(
      "variable.parameter.zig",
    );
  });
});
