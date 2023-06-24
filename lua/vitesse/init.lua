local vitesse_colors = require("vitesse.colors").colors
local vitesse_themes = require("vitesse.colors").themes

local cmd = vim.cmd
local fn = vim.fn

-- merged opts, defaults <- user_opts
local opts = {}
local defaults = {
  comment_italics = true,
  transparent_background = true,
  transparent_float_background = true,
  reverse_visual = false,
  dim_nc = false,
  cmp_cmdline_disable_search_highlight_group = false,
  telescope_border_follow_float_background = false,
}

local M = {
  Color = require("colorbuddy.init").Color,
  colors = require("colorbuddy.init").colors,
  Group = require("colorbuddy.init").Group,
  groups = require("colorbuddy.init").groups,
  styles = require("colorbuddy.init").styles,
}

function M.setup(user_opts)
  user_opts = user_opts or {}
  opts = vim.tbl_extend("force", defaults, user_opts)
end

function M.load()
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

  Color.new("bg", vitesse_colors.background)

  Color.new("black", vitesse_colors.black)
  Color.new("black1", vitesse_colors.black1)
  Color.new("black2", vitesse_colors.black2)
  Color.new("black3", vitesse_colors.black3)
  Color.new("white3", vitesse_colors.white3)
  Color.new("white2", vitesse_colors.white2)
  Color.new("white1", vitesse_colors.white1)
  Color.new("white", vitesse_colors.white)
  Color.new("purple6", vitesse_colors.purple6)

  Color.new("primary", vitesse_themes.primary)

  Color.new("baseForeground", vitesse_themes.foreground)
  Color.new("activeForeground", vitesse_themes.activeForeground)
  Color.new("secondaryForeground", vitesse_themes.secondaryForeground)
  Color.new("ignored", vitesse_themes.ignored)
  Color.new("border", vitesse_themes.border)

  Color.new("baseBackground", vitesse_themes.background)
  Color.new("activeBackground", vitesse_themes.activeBackground)

  Color.new("lowBackground", vitesse_themes.lowBackground)
  Color.new("lowActiveBackground", vitesse_themes.lowActiveBackground)
  Color.new("lowBorder", vitesse_themes.lowBorder)

  Color.new("comment", vitesse_themes.comment)
  Color.new("string", vitesse_themes.string)
  Color.new("variable", vitesse_themes.variable)
  Color.new("keyword", vitesse_themes.keyword)
  Color.new("number", vitesse_themes.number)
  Color.new("boolean", vitesse_themes.boolean)
  Color.new("operator", vitesse_themes.operator)
  Color.new("func", vitesse_themes.func)
  Color.new("constant", vitesse_themes.constant)
  Color.new("class", vitesse_themes.class)
  Color.new("interface", vitesse_themes.interface)
  Color.new("type", vitesse_themes.type)
  Color.new("builtin", vitesse_themes.builtin)
  Color.new("property", vitesse_themes.property)
  Color.new("namespace", vitesse_themes.namespace)
  Color.new("punctuation", vitesse_themes.punctuation)
  Color.new("decorator", vitesse_themes.decorator)
  Color.new("regex", vitesse_themes.regex)

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

  Color.new("green", vitesse_themes.green)
  Color.new("cyan", vitesse_themes.cyan)
  Color.new("blue", vitesse_themes.blue)
  Color.new("red", vitesse_themes.red)
  Color.new("orange", vitesse_themes.orange)
  Color.new("yellow", vitesse_themes.yellow)
  Color.new("magenta", vitesse_themes.magenta)

  Group.new("Error", colors.red)
  Group.new("Warn", colors.yellow)
  Group.new("Info", colors.blue)
  Group.new("Hint", colors.cyan)

  local normal = {
    fg = colors.baseForeground,
    bg = colors.baseBackground,
    nc_fg = colors.baseForeground,
    float_bg = colors.lowActiveBackground,
  }

  if opts.transparent_background then
    normal.bg = colors.none
  end
  if opts.transparent_float_background then
    normal.float_bg = colors.none
  end
  if opts.dim_nc then
    normal.nc_fg = colors.secondaryForeground
  end
  Group.new("Normal", normal.fg, normal.bg)
  -- normal non-current text, means non-focus window text
  Group.new("NormalNC", normal.nc_fg, normal.bg)

  -- pum (popup menu) float
  Group.new("Pmenu", groups.Normal, normal.float_bg) -- popup menu normal item
  Group.new("PmenuSel", colors.activeBackground, normal.fg, styles.reverse) -- selected item
  Group.new("PmenuSbar", colors.black1, colors.none, styles.reverse)
  Group.new("PmenuThumb", colors.black2, colors.none, styles.reverse)

  -- be nice for this float border to be cyan if active
  Group.new("FloatBorder", colors.lowBorder)

  Group.new("LineNr", colors.ignored:light():light(), colors.none, styles.NONE)
  Group.new("CursorLine", colors.none, colors.lowActiveBackground, styles.NONE)
  Group.new("CursorLineNr", colors.activeForeground, colors.none, styles.NONE)
  Group.new("Cursor", colors.black3, colors.secondaryForeground, styles.NONE)
  Group.link("lCursor", groups.Cursor)
  Group.link("TermCursor", groups.Cursor)
  Group.new("TermCursorNC", colors.black3, colors.activeBackground)

  Group.link("Identifier", groups.Property)

  -- any statement, conditional, repeat (for, do while), label, operator
  Group.new("Statement", colors.green)
  Group.new("PreProc", colors.red) -- was orange
  Group.new("Special", colors.property) -- was red
  Group.new("SpecialKey", colors.property)
  Group.new("Underlined", colors.red)
  Group.new("Strikethrough", colors.activeBackground, colors.none, styles.strikethrough)
  Group.new("Ignore", groups.Comment)
  Group.new("Todo", colors.blue)

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
  Group.new("Visual", colors.none, colors.black3, opts.reverse_visual and styles.reverse or styles.none)
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
  Group.new("WarningMsg", groups.Warn)
  Group.new("WildMenu", colors.baseForeground, colors.black1, styles.reverse)
  Group.new("Folded", colors.secondaryForeground, colors.black1, styles.bold, colors.black3)
  Group.new("FoldColumn", colors.secondaryForeground, colors.black1)

  Group.new("SignColumn", colors.secondaryForeground, colors.none, styles.NONE)
  Group.new("Conceal", colors.blue, colors.none, styles.NONE)

  Group.new("SpellBad", colors.none, colors.none, styles.undercurl, colors.red)
  Group.new("SpellCap", colors.none, colors.none, styles.undercurl, colors.purple6)
  Group.new("SpellRare", colors.none, colors.none, styles.undercurl, colors.cyan)
  Group.new("SpellLocal", colors.none, colors.none, styles.undercurl, colors.yellow)

  Group.new("MatchParen", colors.red, colors.activeBackground, styles.bold)

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

  -- diff
  Group.new("DiffAdd", colors.green, colors.none, styles.bold, colors.green)
  Group.new("DiffChange", colors.orange, colors.none, styles.bold, colors.orange)
  Group.new("DiffDelete", colors.red, colors.none, styles.bold, colors.red)
  Group.new("DiffText", colors.blue, colors.none, styles.bold, colors.blue)

  -- alias ui
  Group.new("Folder", colors.orange)
  Group.new("FolderRoot", colors.blue)

  -- plugins

  -- treesitter, important
  require("vitesse.plugins.treesitter")(opts)
  -- lsp
  require("vitesse.plugins.lsp")(opts)
  -- neomake
  require("vitesse.plugins.neomake")
  -- gitgutter
  require("vitesse.plugins.gitgutter")
  -- gitsigns
  require("vitesse.plugins.gitsigns")
  -- cmp
  require("vitesse.plugins.cmp")(opts)
  -- lspsaga
  require("vitesse.plugins.lspsaga")
  -- telescope
  require("vitesse.plugins.telescope")(opts, { normal = normal })
  -- neogit
  require("vitesse.plugins.neogit")
  -- Primeagen/harpoon
  require("vitesse.plugins.harpoon")
  -- nvim-tree/nvim-tree.lua
  require("vitesse.plugins.nvim-tree")
  -- phaazon/hop.nvim
  require("vitesse.plugins.hop")
  -- j-hui/fidget
  require("vitesse.plugins.fidget")

  require("vitesse.plugins.indent-blankline")
  -- folke/which-key.nvim
  require("vitesse.plugins.which-key")
  -- folke/noice.nvim
  require("vitesse.plugins.noice")(opts, { normal = normal })
  -- neo-tree
  require("vitesse.plugins.neo-tree")(opts)
  -- alpha
  require("vitesse.plugins.alpha")(opts)
  -- echasnovski/mini.indentscope
  require("vitesse.plugins.mini-indentscope")(opts)
  -- vim-illuminate
  require("vitesse.plugins.illuminate")(opts)
  -- seblj/nvim-tabline
  require("vitesse.plugins.tabline")(opts, { normal = normal })

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
    Warn = groups.Warn,
    Warning = groups.Warn,
    Information = groups.Info,
    Hint = groups.Hint,
  }
  for _, lsp in pairs({ "Error", "Warning", "Information", "Hint" }) do
    local lspGroup = Group.new(M.translate("LspDiagnosticsDefault" .. lsp), lspColors[lsp])
    Group.link(M.translate("LspDiagnosticsVirtualText" .. lsp), lspGroup)
    Group.new(M.translate("LspDiagnosticsUnderline" .. lsp), colors.none, colors.none, styles.undercurl, lspColors[lsp])
  end

  for _, name in pairs({ "LspReferenceText", "LspReferenceRead", "LspReferenceWrite" }) do
    Group.link(M.translate(name), groups.CursorLine)
  end

  return M
end

return M
