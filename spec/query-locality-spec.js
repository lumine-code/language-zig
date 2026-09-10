const fs = require("fs");
const path = require("path");
const { Point } = require("lumine");

describe("Zig highlight query locality", () => {
  let editor;

  beforeEach(async () => {
    await lumine.packages.activatePackage("language-zig");
    editor = await lumine.workspace.open();
    editor.setGrammar(lumine.grammars.grammarForScopeName("source.zig"));
  });

  afterEach(() => editor?.destroy());

  async function setUp(text) {
    editor.setText(text);
    await editor.languageMode.ready;
  }

  function tileCaptures() {
    const layer = editor.languageMode.rootLanguageLayer;
    return layer.queries.highlightsQuery.captures(layer.tree.rootNode, {
      startPosition: new Point(2998, 0),
      endPosition: new Point(3004, 0),
    });
  }

  it("keeps initializer members local inside a 6000-row initializer", async () => {
    const query = fs.readFileSync(
      path.join(__dirname, "..", "grammars", "zig-highlights.scm"),
      "utf8",
    );
    expect(query).not.toContain("(initializer_list\n  (assignment_expression");

    await setUp("const value = .{ .field = other }; ");
    expect(editor.scopeDescriptorForBufferPosition([0, 18]).getScopesArray()).toContain(
      "variable.other.member.zig",
    );

    const lines = ["const value = .{"];
    for (let i = 0; i < 6000; i++) lines.push(`  .field_${i} = value_${i},`);
    lines.push("};");
    await setUp(lines.join("\r\n"));
    expect(editor.languageMode.rootLanguageLayer.tree.rootNode.hasError).toBe(false);
    expect(tileCaptures().length).toBeLessThanOrEqual(96);
  });
});
