describe("zig editing settings", () => {
  let editor;
  beforeEach(async () => {
    jasmine.useRealClock();
    editor = null;
    await lumine.packages.activatePackage("language-zig");
  });
  afterEach(() => editor?.destroy());
  async function start(scope, text = "value") {
    editor ??= await lumine.workspace.open();
    editor.setGrammar(lumine.grammars.grammarForScopeName(scope));
    editor.setText(text);
    expect(await editor.whenGrammarSettled()).toBe(true);
    editor.update({ autoIndent: false });
  }
  it("keeps language identifier characters inside word selection", async () => {
    for (const [scope, text, column, expected] of [["source.zig", "@import", 3, "@import"]]) {
      await start(scope, text);
      editor.setCursorBufferPosition([0, column]);
      expect(editor.getWordUnderCursor())
        .withContext(scope + " " + text)
        .toBe(expected);
    }
  });
});
