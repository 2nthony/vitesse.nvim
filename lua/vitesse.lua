local cmd = vim.cmd
local fn = vim.fn

local defaults = {
  comment_italics = true,
  background_set = false,
  background_color = require("colorbuddy.init").Color.none,
}

local M = {
  Color = require("colorbuddy.init").Color,
  colors = require("colorbuddy.init").colors,
  Group = require("colorbuddy.init").Group,
  groups = require("colorbuddy.init").groups,
  styles = require("colorbuddy.init").styles,
}

function M.setup(opts)
  if not opts then
    opts = {}
  end

  for k, v in pairs(defaults) do
    if opts[k] == nil then
      opts[k] = v
    end
  end

  -- typos are annoying
  for k, _ in pairs(opts) do
    if defaults[k] == nil then
      print("vitesse: unknown setting: ", k)
    end
  end

  -- only needed to clear when not the default colorscheme
  if vim.g.colors_name then
    vim.cmd("hi clear")
  end

  if fn.exists("syntax_on") then
    cmd("syntax reset")
  end

  vim.g.colors_name = "vitesse"

  local Color = M.Color
  local colors = M.colors
  local Group = M.Group
  local groups = M.groups
  local styles = M.styles

  Color.new("black", "#111111")
  Color.new("black1", "#252525")
  Color.new("black2", "#393939")
  Color.new("black3", "#4d4d4d")
  Color.new("white3", "#c3c3c3")
  Color.new("white2", "#d7d7d7")
  Color.new("white1", "#ebebeb")
  Color.new("white", "#ffffff")

  Color.new("primary", "#4d9375")

  Color.new("baseForeground", "#c8c5b8")
  Color.new("activeForeground", "#bebaab")
  Color.new("secondaryForeground", "#83827d")
  Color.new("ignored", "#383837")
  Color.new("border", "#191919")

  Color.new("background", "#121212")
  Color.new("activeBackground", "#181818")

  Color.new("lowBackground", "#222222")
  Color.new("lowActiveBackground", "#292929")
  Color.new("lowBorder", "#252525")

  Color.new("comment", "#5c6b5e")
  Color.new("string", "#c98a7d")
  Color.new("variable", "#bd976a")
  Color.new("keyword", "#4d9375")
  Color.new("number", "#4C9A91")
  Color.new("boolean", "#4d9375")
  Color.new("operator", "#cb7676")
  Color.new("func", "#80a665")
  Color.new("constant", "#c99076")
  Color.new("class", "#6893BF")
  Color.new("interface", "#5DA994")
  Color.new("type", "#5da9a7")
  Color.new("builtin", "#cb7676")
  Color.new("property", "#b8a965")
  Color.new("namespace", "#db889a")
  Color.new("punctuation", "#666666")
  Color.new("decorator", "#bd8f8f")
  Color.new("regex", "#c4704f")

  Group.new("Comment", colors.comment, colors.none, opts.comment_italics and styles.italic or styles.NONE)
  Group.new("String", colors.string)
  Group.new("Variable", colors.variable)
  Group.new("Keyword", colors.keyword)
  Group.new("Number", colors.number)
  Group.new("Boolean", colors.boolean)
  Group.new("Operator", colors.operator)
  Group.new("Function", colors.func)
  Group.new("Constant", colors.constant)
  Group.new("Class", colors.class)
  Group.new("Interface", colors.interface)
  Group.new("Type", colors.type)
  Group.new("Builtin", colors.builtin)
  Group.new("Property", colors.property)
  Group.new("Namespace", colors.namespace)
  Group.new("Punctuation", colors.punctuation)
  Group.new("Decorator", colors.decorator)
  Group.new("Regex", colors.regex)

  Color.new("green", "#4d9375")
  Color.new("cyan", "#5eaab5")
  Color.new("blue", "#6394bf")
  Color.new("red", "#cb7676")
  Color.new("orange", "#d4976c")
  Color.new("yellow", "#e6cc77")
  Color.new("magenta", "#d9739f")
  Color.new("purple6", "#5a32a3")

  Color.new("bg", colors.background)
  Group.new("Error", colors.red)
  Group.new("Warning", colors.yellow)
  Group.new("Information", colors.blue)
  Group.new("Hint", colors.cyan)

  if opts["background_set"] and opts["background_color"] == Color.none then
    opts["background_color"] = colors.background
  end

  local bg_color = opts["background_color"]

  -- normal non-current text
  Group.new("Normal", colors.baseForeground, bg_color)
  Group.new("NormalNC", colors.secondaryForeground, bg_color)

  Group.new("Identifier", colors.class)

  -- any statement, conditional, repeat (for, do while), label, operator
  Group.new("Statement", colors.green)
  Group.new("PreProc", colors.red) -- was orange
  Group.new("Special", colors.property) -- was red
  Group.new("SpecialKey", colors.property)
  Group.new("Underlined", colors.red)
  Group.new("Strikethrough", colors.activeBackground, colors.none, styles.strikethrough)
  Group.new("Ignore", colors.activeBackground)
  Group.new("Error", colors.red)
  Group.new("Todo", colors.magenta, colors.none, styles.bold)

  Group.link("Include", groups.PreProc)
  Group.link("Macro", groups.PreProc)
  Group.link("Delimiter", groups.Special)
  Group.link("Repeat", groups.Statement)
  Group.link("Conditional", groups.Statement)
  Group.link("Define", groups.PreProc)
  Group.link("Character", groups.Constant)
  Group.link("Float", groups.Constant)
  Group.link("Debug", groups.Special)
  Group.link("Label", groups.Statement)
  Group.link("Exception", groups.Statement)
  Group.link("StorageClass", groups.Type)

  Group.link("SpecialChar", groups.Special)
  Group.new("SpecialKey", colors.black3, colors.black1, styles.bold)
  Group.link("String", groups.String)
  Group.new("NonText", colors.black3, colors.none, styles.bold)
  Group.new("StatusLine", colors.lowBackground, colors.black1, styles.reverse)
  Group.new("StatusLineNC", colors.lowActiveBackground, colors.black1, styles.reverse)
  Group.new("Visual", colors.none, colors.black3)
  Group.new("Directory", colors.blue)
  Group.new("ErrorMsg", colors.red, colors.none, styles.reverse)

  Group.new("IncSearch", colors.orange, colors.none, styles.standout)
  Group.new("Search", colors.yellow, colors.none, styles.reverse)

  Group.new("MoreMsg", colors.blue, colors.none, styles.NONE)
  Group.new("ModeMsg", colors.blue, colors.none, styles.NONE)
  Group.new("Question", colors.cyan, colors.none, styles.bold)
  Group.new("VertSplit", colors.black3, colors.none, styles.NONE)
  Group.new("Title", colors.orange, colors.none, styles.bold)
  Group.new("VisualNOS", colors.none, colors.black1, styles.reverse)
  Group.new("WarningMsg", colors.orange, colors.none, styles.bold)
  Group.new("WildMenu", colors.baseForeground, colors.black1, styles.reverse)
  Group.new("Folded", colors.secondaryForeground, colors.black1, styles.bold, colors.black3)
  Group.new("FoldColumn", colors.secondaryForeground, colors.black1)

  Group.new("DiffAdd", colors.green, colors.black1, styles.bold, colors.green)
  Group.new("DiffChange", colors.yellow, colors.black1, styles.bold, colors.yellow)
  Group.new("DiffDelete", colors.red, colors.black1, styles.bold)
  Group.new("DiffText", colors.blue, colors.black1, styles.bold, colors.blue)

  Group.new("SignColumn", colors.secondaryForeground, colors.none, styles.NONE)
  Group.new("Conceal", colors.blue, colors.none, styles.NONE)

  Group.new("SpellBad", colors.none, colors.none, styles.undercurl, colors.red)
  Group.new("SpellCap", colors.none, colors.none, styles.undercurl, colors.purple6)
  Group.new("SpellRare", colors.none, colors.none, styles.undercurl, colors.cyan)
  Group.new("SpellLocal", colors.none, colors.none, styles.undercurl, colors.yellow)
  -- These are nice alternatives if you like a little more color
  --Group.new("SpellBad", colors.purple6, colors.bg, styles.undercurl)
  --Group.new("SpellCap", colors.purple6, colors.bg, styles.undercurl)
  --Group.new("SpellLocal", colors.yellow, colors.bg, styles.undercurl)
  --Group.new("SpellRare", colors.cyan, colors.bg, styles.undercurl)

  -- pum (popup menu)
  Group.new("Pmenu", groups.Normal, colors.black1, styles.none) -- popup menu normal item
  Group.new("PmenuSel", colors.activeBackground, colors.baseForeground, styles.reverse) -- selected item
  Group.new("PmenuSbar", colors.black1, colors.none, styles.reverse)
  Group.new("PmenuThumb", colors.black2, colors.none, styles.reverse)

  -- be nice for this float border to be cyan if active
  Group.new("FloatBorder", colors.primary)

  Group.new("TabLine", colors.secondaryForeground, colors.black1, styles.NONE, colors.secondaryForeground)
  Group.new("TabLineFill", colors.secondaryForeground, colors.black1)
  Group.new("TabLineSel", colors.yellow, colors.bg)
  Group.new("TabLineSeparatorSel", colors.cyan, colors.none)

  Group.new("LineNr", colors.ignored:light():light(), bg_color, styles.NONE)
  Group.new("CursorLine", colors.none, colors.lowActiveBackground, styles.NONE)
  Group.new("CursorLineNr", colors.activeForeground, colors.none, styles.NONE)
  Group.new("Cursor", colors.black3, colors.secondaryForeground, styles.NONE)
  Group.link("lCursor", groups.Cursor)
  Group.link("TermCursor", groups.Cursor)
  Group.new("TermCursorNC", colors.black3, colors.activeBackground)

  Group.new("MatchParen", colors.red, colors.activeBackground, styles.bold)

  Group.new("GitGutterAdd", colors.green)
  Group.new("GitGutterChange", colors.yellow)
  Group.new("GitGutterDelete", colors.red)
  Group.new("GitGutterChangeDelete", colors.red)

  Group.new("GitSignsAddLn", colors.green)
  Group.new("GitSignsAddNr", colors.green)
  Group.new("GitSignsChangeLn", colors.yellow)
  Group.new("GitSignsChangeNr", colors.yellow)
  Group.new("GitSignsDeleteLn", colors.red)
  Group.new("GitSignsDeleteNr", colors.red)
  Group.link("GitSignsCurrentLineBlame", groups.Comment)

  -- vim highlighting
  Group.link("vimVar", groups.Identifier)
  Group.link("vimFunc", groups.Identifier)
  Group.link("vimUserFunc", groups.Identifier)
  Group.link("helpSpecial", groups.Special)
  Group.link("vimSet", groups.Normal)
  Group.link("vimSetEqual", groups.Normal)
  Group.new("vimCommentString", colors.purple6)
  Group.new("vimCommand", colors.yellow)
  Group.new("vimCmdSep", colors.blue, colors.NONE, styles.bold)
  Group.new("helpExample", colors.baseForeground)
  Group.new("helpOption", colors.cyan)
  Group.new("helpNote", colors.magenta)
  Group.new("helpVim", colors.magenta)
  Group.new("helpHyperTextJump", colors.blue, colors.NONE, styles.underline)
  Group.new("helpHyperTextEntry", colors.green)
  Group.new("vimIsCommand", colors.black3)
  Group.new("vimSynMtchOpt", colors.yellow)
  Group.new("vimSynType", colors.cyan)
  Group.new("vimHiLink", colors.blue)
  Group.new("vimGroup", colors.blue, colors.NONE, styles.underline + styles.bold)

  Group.new("gitcommitSummary", colors.green)
  Group.new("gitcommitComment", colors.activeBackground, colors.NONE, styles.italic)
  Group.link("gitcommitUntracked", groups.gitcommitComment)
  Group.link("gitcommitDiscarded", groups.gitcommitComment)
  Group.new("gitcommitSelected", groups.gitcommitComment)
  Group.new("gitcommitUnmerged", colors.green, colors.NONE, styles.bold)
  Group.new("gitcommitOnBranch", colors.activeBackground, colors.NONE, styles.bold)
  Group.new("gitcommitBranch", colors.magenta, colors.NONE, styles.bold)
  Group.link("gitcommitNoBranch", groups.gitcommitBranch)
  Group.new("gitcommitDiscardedType", colors.red)
  Group.new("gitcommitSelectedType", colors.green)
  Group.new("gitcommitHeader", colors.activeBackground)
  Group.new("gitcommitUntrackedFile", colors.cyan)
  Group.new("gitcommitDiscardedFile", colors.red)
  Group.new("gitcommitSelectedFile", colors.green)
  Group.new("gitcommitUnmergedFile", colors.yellow)
  Group.new("gitcommitFile", colors.secondaryForeground)
  Group.link("gitcommitDiscardedArrow", groups.gitCommitDiscardedFile)
  Group.link("gitcommitSelectedArrow", groups.gitCommitSelectedFile)
  Group.link("gitcommitUnmergedArrow", groups.gitCommitUnmergedFile)

  Group.link("diffAdded", groups.Statement)
  Group.link("diffLine", groups.Identifier)

  Group.new("NeomakeErrorSign", colors.orange)
  Group.new("NeomakeWarningSign", colors.yellow)
  Group.new("NeomakeMessageSign", colors.cyan)
  Group.new("NeomakeNeomakeInfoSign", colors.green)

  Group.new("CmpItemKind", colors.green)
  Group.new("CmpItemMenu", groups.NormalNC)
  -- Group.new('CmpItemAbbr', colors.secondaryForeground, colors.none, styles.none)
  -- Group.new('CmpItemAbbrMatch', colors.secondaryForeground, colors.none, styles.none)
  Group.new("CmpItemKindText", colors.white, colors.none, styles.none)
  Group.new("CmpItemKindMethod", colors.green, colors.none, styles.none)
  Group.new("CmpItemKindFunction", colors.blue, colors.none, styles.none)
  Group.new("CmpItemKindConstructor", colors.orange, colors.none, styles.none)
  Group.new("CmpItemKindField", colors.yellow, colors.none, styles.none)
  Group.new("CmpItemKindVariable", colors.orange, colors.none, styles.none)
  Group.new("CmpitemKindClass", colors.yellow, colors.none, styles.none)
  Group.new("CmpItemKindInterface", colors.yellow, colors.none, styles.none)
  Group.new("CmpItemKindModule", colors.green, colors.none, styles.none)
  Group.new("CmpItemKindProperty", colors.green, colors.none, styles.none)
  Group.new("CmpItemKindUnit", colors.orange, colors.none, styles.none)
  Group.new("CmpItemKindValue", colors.cyan, colors.none, styles.none)
  Group.new("CmpItemKindEnum", colors.yellow, colors.none, styles.none)
  Group.new("CmpItemKindKeyword", colors.green, colors.none, styles.none)
  Group.new("CmpItemKindSnippet", colors.magenta, colors.none, styles.none)
  Group.new("CmpItemKindColor", colors.magenta, colors.none, styles.none)
  Group.new("CmpItemKindFile", colors.purple6, colors.none, styles.none)
  Group.new("CmpItemKindReference", colors.purple6, colors.none, styles.none)
  Group.new("CmpItemKindFolder", colors.purple6, colors.none, styles.none)
  Group.new("CmpItemKindEnumMember", colors.cyan, colors.none, styles.none)
  Group.new("CmpItemKindConstant", colors.cyan, colors.none, styles.none)
  Group.new("CmpItemKindStruct", colors.yellow, colors.none, styles.none)
  Group.new("CmpItemKindEvent", colors.orange, colors.none, styles.none)
  Group.new("CmpItemKindOperator", colors.cyan, colors.none, styles.none)
  Group.new("CmpItemKindTypeParameter", colors.orange, colors.none, styles.none)

  Group.new("LspSagaCodeActionTitle", colors.green)
  Group.new("LspSagaBorderTitle", colors.yellow, colors.none, styles.bold)
  Group.new("LspSagaDiagnosticHeader", colors.yellow)
  Group.new("ProviderTruncateLine", colors.black1)
  Group.new("LspSagaShTruncateLine", groups.ProviderTruncateLine)
  Group.new("LspSagaDocTruncateLine", groups.ProviderTruncateLine)
  Group.new("LspSagaCodeActionTruncateLine", groups.ProviderTruncateLine)
  Group.new("LspSagaHoverBorder", groups.FloatBorder)
  Group.new("LspSagaRenameBorder", groups.LspSagaHoverBorder)
  Group.new("LSPSagaDiagnosticBorder", groups.LspSagaHoverBorder)
  Group.new("LspSagaSignatureHelpBorder", groups.LspSagaHoverBorder)
  Group.new("LspSagaCodeActionBorder", groups.LspSagaHoverBorder)
  Group.new("LspSagaLspFinderBorder", groups.LspSagaHoverBorder)
  Group.new("LspSagaFloatWinBorder", groups.LspSagaHoverBorder)
  Group.new("LspSagaSignatureHelpBorder", groups.LspSagaHoverBorder)
  Group.new("LspSagaDefPreviewBorder", groups.LspSagaHoverBorder)
  Group.new("LspSagaAutoPreviewBorder", groups.LspSagaHoverBorder)
  Group.new("LspFloatWinBorder", groups.LspSagaHoverBorder)
  Group.new("LspLinesDiagBorder", groups.LspSagaHoverBorder)
  Group.new("LspSagaFinderSelection", colors.green, colors.none, styles.bold)
  --Group.new('SagaShadow', colors.black1)

  Group.new("TelescopeMatching", colors.orange, groups.Special, groups.Special, groups.Special)
  Group.new("TelescopeBorder", groups.FloatBorder) -- float border not quite dark enough, maybe that needs to change?
  Group.new("TelescopePromptBorder", groups.FloatBorder) -- active border lighter for clarity
  Group.new("TelescopeTitle", groups.Normal) -- separate them from the border a little, but not make them pop
  Group.new("TelescopePromptPrefix", groups.Normal) -- default is groups.Identifier
  Group.link("TelescopeSelection", groups.CursorLine)
  Group.new("TelescopeSelectionCaret", colors.cyan)

  Group.new("NeogitDiffAddHighlight", colors.blue, colors.red)
  Group.new("NeogitDiffDeleteHighlight", colors.blue, colors.red)
  Group.new("NeogitHunkHeader", groups.Normal, colors.black1)
  Group.new("NeogitHunkHeaderHighlight", groups.Normal, colors.red)
  Group.new("NeogitDiffContextHighlight", colors.baseForeground, colors.black1)
  Group.new("NeogitCommandText", groups.Normal)
  Group.new("NeogitCommandTimeText", groups.Normal)
  Group.new("NeogitCommandCodeNormal", groups.Normal)
  Group.new("NeogitCommandCodeError", groups.Error)
  Group.new("NeogitNotificationError", groups.Error, colors.none)
  Group.new("NeogitNotificationInfo", groups.Information, colors.none)
  Group.new("NeogitNotificationWarning", groups.Warning, colors.none)

  -- seblj/nvim-tabline
  Group.new("TabLineSeparatorActive", colors.cyan)
  Group.link("TabLineModifiedSeparatorActive", groups.TablineSeparatorActive)

  -- kevinhwang91/nvim-bqf
  Group.new("BqfPreviewBorder", colors.activeBackground)
  Group.new("BqfSign", colors.cyan)

  -- Primeagen/harpoon
  Group.new("HarpoonBorder", colors.cyan)
  Group.new("HarpoonWindow", groups.Normal)

  -- nvim-tree/nvim-tree.lua
  Group.new("NvimTreeFolderIcon", colors.blue)
  Group.new("NvimTreeRootFolder", colors.orange)
  Group.new("NvimTreeImageFile", colors.orange)
  Group.new("NvimTreeSpecialFile", colors.orange, colors.none, styles.bold + styles.underline)

  -- phaazon/hop.nvim
  Group.link("HopNextKey", groups.IncSearch)
  Group.link("HopNextKey1", groups.IncSearch)
  Group.link("HopNextKey2", groups.IncSearch)

  -- https://github.com/j-hui/fidget.nvim (for some reason the background
  -- is only correct if used with background_set = true) even when set below)
  Group.new("FidgetTitle", colors.magenta)
  Group.new("FidgetTask", colors.secondaryForeground)

  -- TreeSitter
  Group.link("TSBoolean", groups.Boolean)
  Group.link("TSCharacter", groups.Character)
  Group.link("TSComment", groups.Comment)
  Group.link("TSConditional", groups.Conditional)
  Group.link("TSConstant", groups.Constant)
  Group.link("TSConstBuiltin", groups.Builtin)
  Group.link("TSConstMacro", groups.Constant)
  Group.link("TSError", groups.Error)
  Group.link("TSException", groups.Exception)
  Group.link("TSField", groups.Identifier)
  Group.link("TSFloat", groups.Constant)
  Group.link("TSFunction", groups.Function)
  Group.link("TSFuncBuiltin", groups.Builtin)
  Group.link("TSFuncMacro", groups.Function)
  Group.link("TSInclude", groups.Include)
  Group.link("TSKeyword", groups.Keyword)
  Group.link("TSLabel", groups.Statement)
  Group.link("TSMethod", groups.Function)
  Group.link("TSNamespace", groups.Namespace)
  Group.link("TSNumber", groups.Number)
  Group.link("TSOperator", groups.Operator)
  Group.link("TSParameterReference", groups.Identifier)
  Group.link("TSProperty", groups.Property)
  Group.link("TSPunctDelimiter", groups.Delimiter)
  Group.link("TSPunctBracket", groups.Punctuation)
  Group.link("TSPunctSpecial", groups.Special)
  Group.link("TSRepeat", groups.Repeat)
  Group.link("TSString", groups.String)
  Group.link("TSStringRegex", groups.Regex)
  Group.link("TSStringEscape", groups.String)
  Group.new("TSStrong", colors.activeForeground, colors.none, styles.bold)
  Group.link("TSConstructor", groups.Function)
  Group.link("TSKeywordFunction", groups.Keyword)
  Group.new("TSLiteral", groups.Normal)
  Group.link("TSParameter", groups.Identifier)
  Group.link("TSVariable", groups.Variable)
  Group.link("TSVariableBuiltin", groups.Builtin)
  Group.link("TSTag", groups.Special)
  Group.link("TSTagDelimiter", groups.Delimiter)
  Group.link("TSTitle", groups.Title)
  Group.link("TSType", groups.Type)
  Group.link("TSTypeBuiltin", groups.Builtin)

  Group.link("DiagnosticError", groups.Error)
  Group.new("DiagnosticWarn", colors.yellow)
  Group.new("DiagnosticInfo", colors.cyan)
  Group.new("DiagnosticHint", colors.green)
  Group.new("DiagnosticUnderlineError", colors.none, colors.none, styles.underline)
  Group.new("DiagnosticUnderlineWarn", colors.none, colors.none, styles.underline)
  Group.new("DiagnosticUnderlineInfo", colors.none, colors.none, styles.underline)
  Group.new("DiagnosticUnderlineHint", colors.none, colors.none, styles.underline)
  Group.link("DiagnosticVirtualTextHint", groups.Comment)
  Group.link("DiagnosticTextWarn", groups.WarningMsg)

  Group.new("LspReferenceRead", colors.none, colors.none, styles.underline)
  Group.link("LspReferenceText", groups.LspReferenceRead)
  Group.new("LspReferenceWrite", colors.none, colors.none, styles.underline)

  -- folke/which-key.nvim
  Group.new("WhichKeySeparator", colors.activeBackground, colors.black1, styles.bold)
  Group.new("WhichKeyDesc", colors.cyan, colors.black1)

  -- group names with an ampersand throw an error until they gain support in 0.8.0
  if fn.has("nvim-0.8.0") then
    -- XML-like tags
    Group.new("@tag", colors.green)
    Group.new("@tag.attribute", colors.property)
    Group.new("@tag.delimiter", colors.punctuation)

    Group.new("@none", colors.none)
    Group.link("@comment", groups.Comment)
    Group.link("@error", groups.Error)
    Group.link("@preproc", groups.PreProc)
    Group.link("@define", groups.Define)
    Group.link("@operator", groups.Operator)

    Group.new("@punctuation", colors.punctuation)
    Group.link("@punctuation.delimiter", groups.Delimiter)
    Group.new("@punctuation.bracket", colors.cyan)
    Group.link("@punctuation.special", groups.Builtin)

    Group.link("@string", groups.String)
    Group.link("@string.regex", groups.Regex)
    Group.link("@string.escape", groups.String)
    Group.link("@string.special", groups.Special)

    Group.link("@character", groups.Character)
    Group.link("@character.special", groups.Special)

    Group.link("@boolean", groups.Builtin)
    Group.link("@number", groups.Number)
    Group.link("@float", groups.Float)

    Group.link("@function", groups.Function)
    Group.link("@function.call", groups.Function)
    Group.link("@function.builtin", groups.Function)
    Group.link("@function.macro", groups.Macro)

    Group.link("@method", groups.Function)
    Group.link("@method.call", groups.Function)

    Group.link("@constructor", groups.Function)
    -- not sure about this one, special is true and kinda nice?
    Group.link("@parameter", groups.Variable)

    Group.link("@keyword", groups.Keyword)
    Group.link("@keyword.function", groups.Operator)
    Group.link("@keyword.operator", groups.Operator)
    Group.link("@keyword.return", groups.Keyword)

    Group.link("@conditional", groups.Conditional)
    Group.link("@repeat", groups.Repeat)
    Group.link("@debug", groups.Debug)
    Group.link("@label", groups.Label)
    Group.link("@include", groups.Include)
    Group.link("@exception", groups.Exception)

    Group.link("@type", groups.Type)
    Group.link("@type.builtin", groups.Type)
    Group.link("@type.qualifier", groups.Builtin)
    Group.link("@type.definition", groups.Type)

    Group.link("@storageclass", groups.Keyword)
    Group.link("@attribute", groups.Function)
    Group.link("@field", groups.Identifier)
    Group.link("@property", groups.Property)

    Group.new("@variable", colors.variable)
    Group.link("@variable.builtin", groups.Variable)

    Group.link("@constant", groups.Constant)
    Group.link("@constant.builtin", groups.Constant)
    Group.link("@constant.macro", groups.Constant)

    Group.link("@namespace", groups.Namespace)
    Group.link("@symbol", groups.Identifier)

    Group.link("@text", groups.Normal)
    Group.new("@text.strong", colors.baseForeground, colors.none, styles.bold)
    Group.new("@text.emphasis", colors.white, colors.none, styles.bold)
    Group.link("@text.underline", groups.Underlined)
    Group.link("@text.strike", groups.Strikethrough)
    Group.link("@text.title", groups.Title)
    Group.link("@text.literal", groups.String)
    Group.link("@text.uri", groups.Underlined)
    Group.link("@text.math", groups.Special)
    Group.link("@text.environment", groups.Macro)
    Group.link("@text.environment.name", groups.Type)
    Group.link("@text.reference", groups.String)

    Group.link("@text.todo", groups.Todo)
    Group.link("@text.note", groups.Comment)
    Group.link("@text.warning", groups.WarningMsg)
    Group.new("@text.danger", colors.red, colors.none, styles.bold)
  end

  function M.translate(group)
    if fn.has("nvim-0.6.0") == 0 then
      return group
    end

    if not string.match(group, "^LspDiagnostics") then
      return group
    end

    local translated = group
    translated = string.gsub(translated, "^LspDiagnosticsDefault", "Diagnostic")
    translated = string.gsub(translated, "^LspDiagnostics", "Diagnostic")
    translated = string.gsub(translated, "Warning$", "Warn")
    translated = string.gsub(translated, "Information$", "Info")
    return translated
  end

  local lspColors = {
    Error = groups.Error,
    Warning = groups.Warning,
    Information = groups.Information,
    Hint = groups.Hint,
  }
  for _, lsp in pairs({ "Error", "Warning", "Information", "Hint" }) do
    local lspGroup = Group.new(M.translate("LspDiagnosticsDefault" .. lsp), lspColors[lsp])
    Group.link(M.translate("LspDiagnosticsVirtualText" .. lsp), lspGroup)
    Group.new(
      M.translate("LspDiagnosticsUnderline" .. lsp),
      colors.none,
      colors.none,
      styles.undercurl,
      lspColors[lsp]
    )
  end

  for _, name in pairs({ "LspReferenceText", "LspReferenceRead", "LspReferenceWrite" }) do
    Group.link(M.translate(name), groups.CursorLine)
  end

  return M
end

return M
