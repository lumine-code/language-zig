describe("Zig identifier highlighting", () => {
  let editor;

  beforeEach(async () => {
    jasmine.useRealClock();
    for (const method of ["openExternal", "openPath", "showItemInFolder", "openApplication"])
      spyOn(lumine.shell, method).and.resolveTo();
    spyOn(lumine.application, "openWindow").and.resolveTo();
    const pack = await lumine.packages.activatePackage("language-zig");
    await pack.resourceLoadPromise;
    editor = await lumine.workspace.open();
    editor.setGrammar(lumine.grammars.grammarForScopeName("source.zig"));
  });

  afterEach(() => editor?.destroy());

  async function highlight(text) {
    editor.setText(text);
    await editor.languageMode.ready;
    await editor.languageMode.atTransactionEnd();
    expect(editor.languageMode.tree.rootNode.hasError)
      .withContext(editor.languageMode.tree.rootNode.toString())
      .toBe(false);
  }

  function scopesAt(word) {
    const column = editor.lineTextForBufferRow(0).indexOf(word);
    expect(column).toBeGreaterThanOrEqual(0);
    return editor.scopeDescriptorForBufferPosition([0, column]).getScopesArray();
  }

  it("keeps a lowercase local variable out of type and constant colors", async () => {
    await highlight("fn read() void { var counter = 0; counter += 1; }");
    const scopes = scopesAt("counter");
    expect(scopes).toContain("variable.other.zig");
    expect(scopes).not.toContain("support.type.zig");
    expect(scopes).not.toContain("constant.other.zig");
  });

  it("keeps a lowercase parameter out of type and constant colors", async () => {
    await highlight("fn read(value: u32) u32 { return value; }");
    const scopes = scopesAt("value");
    expect(scopes).toContain("variable.parameter.zig");
    expect(scopes).not.toContain("support.type.zig");
    expect(scopes).not.toContain("constant.other.zig");
  });

  it("preserves named types, uppercase constants and built-in type colors", async () => {
    await highlight(
      "fn read() void { const Widget = struct { value: u32 }; const MAX_SIZE = 12; const count: u32 = MAX_SIZE; }",
    );
    expect(scopesAt("Widget")).toContain("support.type.zig");
    expect(scopesAt("MAX_SIZE")).toContain("constant.other.zig");
    expect(scopesAt("u32")).toContain("support.type.builtin.zig");
  });
});
