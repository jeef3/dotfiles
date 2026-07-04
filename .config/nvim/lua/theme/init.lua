-- =============================================================================
-- Princess — Neovim Colorscheme
-- Based on Tinacious Design:
-- https://github.com/tinacious/vscode-tinacious-design-syntax
-- =============================================================================

local p = require("theme.palette")

-- Semantic aliases
local bg = p.silver_900
local fg = p.silver_200
local white = p.silver_100
local comment = p.silver_500
local gutter = p.silver_600
local subtle = p.silver_700
local float_bg = p.silver_800
local selected_fg = p.silver_100
local selected_bg = p.blue_700

local pink = p.pink_500
local blue = p.blue_500
local turquoise = p.turquoise_500
local green = p.green_500
local purple = p.purple_500
local orange = p.orange_500

-- Background tints for git/diagnostic gutters
local pink_bg = p.pink_900
local blue_bg = p.blue_900
local turquoise_bg = p.turquoise_900
local green_bg = p.green_900
local orange_bg = p.orange_900
local purple_bg = p.purple_900

-- Helper
local function hi(name, opts)
  vim.api.nvim_set_hl(0, name, opts)
end

local function setup()
  vim.cmd("hi clear")
  vim.g.colors_name = "princess"

  -- === Editor ===
  hi("Normal", { fg = fg, bg = bg })
  hi("NormalNC", { fg = fg, bg = bg })
  hi("NormalFloat", { bg = subtle })
  hi("FloatBorder", { fg = gutter, bg = subtle })
  hi("Cursor", { bg = fg })
  hi("CursorLine", { bg = subtle })
  hi("CursorColumn", { link = "CursorLine" })
  hi("ColorColumn", { bg = subtle })
  hi("Visual", { bg = subtle })
  hi("Comment", { fg = comment, italic = true })
  hi("WinBar", { fg = p.silver_500, bg = float_bg })
  hi("WinBarNC", { fg = p.silver_600, bg = bg })

  hi("LineNr", { fg = gutter, bg = bg })
  hi("CursorLineNr", { fg = p.orange_400, bg = subtle })
  hi("EndOfBuffer", { fg = gutter, bg = bg })
  hi("SignColumn", { bg = bg })

  hi("Search", { fg = p.orange_900, bg = orange })
  hi("IncSearch", { fg = p.orange_900, bg = p.orange_400 })

  -- Cursor shapes
  hi("InsertCursor", { bg = green })
  hi("VisualCursor", { bg = pink })
  hi("ReplaceCursor", { bg = orange })
  hi("CommandCursor", { bg = purple })

  hi("ErrorMsg", { fg = pink })
  hi("MsgArea", { bg = bg })
  hi("WinSeparator", { fg = subtle, bg = bg })

  -- === Tabs ===
  hi("TabLine", { fg = gutter, bg = float_bg })
  hi("TabLineSel", { fg = p.silver_200, bg = subtle, bold = true })
  hi("TabLineFill", { fg = fg, bg = float_bg })
  hi("TabLineSeparator", { fg = gutter, bg = float_bg })
  hi("TabLineSeparatorSel", { fg = pink, bg = subtle })
  hi("TabLineModified", { fg = fg, bg = float_bg })
  hi("TabLineModifiedSel", { fg = fg, bg = subtle })
  hi("TabLineClose", { fg = gutter, bg = float_bg, bold = true })
  hi("TabLineCloseSel", { fg = fg, bg = subtle, bold = true })

  -- === Status Line ===
  hi("StatusLine", { fg = pink })
  hi("StatusLineNC", { fg = p.pink_700 })
  hi("StatusLineNormalA", { fg = fg, bg = p.pink_600, bold = true })
  hi("StatusLineNormalB", { fg = fg, bg = float_bg })
  hi("StatusLineNormalC", { fg = comment, bg = float_bg })
  hi("StatusLineInactiveA", { fg = fg, bg = p.pink_600 })
  hi("StatusLineInactiveB", { fg = fg, bg = float_bg })
  hi("StatusLineInactiveC", { fg = comment, bg = float_bg })
  hi("StatusLineInsert", { fg = fg, bg = p.green_600, bold = true })
  hi("StatusLineReplace", { fg = fg, bg = p.orange_600, bold = true })
  hi("StatusLineCommand", { fg = fg, bg = p.purple_600, bold = true })

  -- === Matching ===
  hi("MatchParen", { bg = p.blue_800, bold = true })
  hi("MatchWord", { bg = p.blue_800, bold = true })

  -- === Misc ===
  hi("Title", { fg = bg, bg = pink, bold = true })
  hi("MoreMsg", { fg = green, bold = true })
  hi("NonText", { fg = subtle, bold = true })

  hi("SpellBad", { undercurl = true, sp = p.pink_700 })
  hi("SpellCap", { undercurl = true, sp = p.blue_700 })
  hi("SpellLocal", { undercurl = true, sp = p.purple_700 })
  hi("SpellRare", { undercurl = true, sp = p.green_700 })

  -- === Syntax (legacy vim groups, fallback when treesitter inactive) ===
  hi("Constant", { fg = purple, bold = true })
  hi("String", { fg = orange })
  hi("Character", { fg = purple })
  hi("Number", { fg = purple })
  hi("Float", { fg = purple })
  hi("Boolean", { fg = purple })

  hi("Identifier", { fg = fg })
  hi("Function", { fg = green })

  hi("Statement", { fg = pink })
  hi("Conditional", { fg = pink })
  hi("Repeat", { fg = pink })
  hi("Label", { fg = pink, bold = true })
  hi("Operator", { fg = fg })
  hi("PreProc", { fg = pink })
  hi("Keyword", { fg = blue, bold = true, italic = true })

  hi("Type", { fg = green })
  hi("Variable", { fg = fg })

  -- === Popup Menu ===
  hi("Pmenu", { fg = fg, bg = float_bg })
  hi("PmenuSbar", { fg = fg, bg = subtle })
  hi("PmenuThumb", { fg = fg, bg = gutter })
  hi("PmenuSel", { fg = selected_fg, bg = selected_bg, bold = true })

  -- === Completion (cmp) ===
  hi("CmpItemAbbrDeprecated", { fg = fg })
  hi("CmpItemAbbrMatch", { fg = blue })
  hi("CmpItemAbbrMatchFuzzy", { fg = blue })
  hi("CmpItemKindVariable", { fg = green })
  hi("CmpItemKindInterface", { fg = green })
  hi("CmpItemKindText", { fg = green })
  hi("CmpItemKindFunction", { fg = pink })
  hi("CmpItemKindMethod", { fg = pink })
  hi("CmpItemKindKeyword", { fg = fg })
  hi("CmpItemKindProperty", { fg = fg })
  hi("CmpItemKindUnit", { fg = fg })

  -- === Diagnostics ===
  hi("DiagnosticError", { fg = pink })
  hi("DiagnosticWarn", { fg = orange })
  hi("DiagnosticHint", { fg = blue })
  hi("DiagnosticInfo", { fg = turquoise })
  hi("DiagnosticUnderlineError", { undercurl = true, sp = pink })
  hi("DiagnosticUnderlineWarn", { undercurl = true, sp = orange })
  hi("DiagnosticUnderlineHint", { undercurl = true, sp = blue })
  hi("DiagnosticUnderlineInfo", { undercurl = true, sp = turquoise })
  hi("DiagnosticVirtualTextError", { fg = pink, bg = p.pink_900 })
  hi("DiagnosticVirtualTextWarn", { fg = orange, bg = p.orange_900 })
  hi("DiagnosticVirtualTextHint", { fg = blue, bg = p.blue_900 })
  hi("DiagnosticVirtualTextInfo", { fg = turquoise, bg = p.turquoise_900 })
  hi("DiagnosticLineNrError", { fg = pink, bg = pink_bg, bold = true })
  hi("DiagnosticLineNrWarn", { fg = orange, bg = orange_bg, bold = true })
  hi("DiagnosticLineNrInfo", { fg = blue, bg = blue_bg, bold = true })
  hi("DiagnosticLineNrHint", { fg = turquoise, bg = blue_bg, bold = true })

  -- === LSP References ===
  hi("LspInlayHint", { fg = p.turquoise_800 })
  hi("LspReferenceText", { bg = float_bg, underline = true, sp = gutter })
  hi("LspReferenceWrite", { bg = float_bg, underline = true, sp = gutter })
  hi("LspReferenceRead", { bg = float_bg, underline = true, sp = gutter })

  -- === Git ===
  hi("GitGutterAdd", { fg = green, bg = green_bg })
  hi("GitGutterChange", { fg = blue, bg = blue_bg })
  hi("GitGutterChangeDelete", { fg = blue, bg = blue_bg })
  hi("GitGutterDelete", { fg = pink, bg = pink_bg })
  hi("DiffAdd", { bg = green_bg })
  hi("DiffChange", { bg = blue_bg })
  hi("DiffDelete", { fg = comment })
  hi("DiffText", { bg = p.blue_800 })
  hi("gitcommitFirstLine", { fg = blue, bold = true })
  hi("gitcommitBranch", { fg = orange, bold = true })

  -- === Folds ===
  hi("Folded", { fg = comment, bg = float_bg, italic = true })
  hi("FoldColumn", { fg = comment, bg = bg })

  -- === Noice ===
  hi("NoiceCmdline", { fg = fg, bg = subtle })
  hi("NoiceCmdlinePopup", { fg = fg, bg = subtle })
  hi("NoiceCmdlinePopupBorder", { fg = subtle, bg = subtle })
  hi("NoiceCmdlineIcon", { fg = gutter })

  -- === Snacks ===
  hi("SnacksIndentScope", { fg = p.orange_700 })
  hi("SnacksPickerTitle", { fg = bg, bg = pink, bold = true })
  hi("SnacksPickerPrompt", { fg = turquoise, bg = subtle })
  hi("SnacksPickerInput", { fg = fg, bg = subtle })
  hi("SnacksPickerBorder", { fg = gutter, bg = subtle })
  hi("SnacksPickerDir", { fg = comment })
  hi("SnacksPickerList", { fg = white, bg = subtle })
  hi("SnacksPickerMatch", { fg = blue })
  hi(
    "SnacksPickerListCursorLine",
    { fg = selected_fg, bg = selected_bg, bold = true }
  )

  -- === DAP ===
  hi("DapBreakpoint", { fg = pink })
  hi("DapBreakpointLine", { bg = pink_bg })
  hi("DapBreakpointCondition", { fg = blue })
  hi("DapBreakpointConditionLine", { bg = blue_bg })
  hi("DapLogPoint", { fg = turquoise })
  hi("DapLogPointLine", { bg = turquoise_bg })
  hi("DapStopped", { fg = orange })
  hi("DapStoppedLine", { bg = orange_bg })
  hi("DapBreakpointRejected", { fg = pink })
  hi("DapBreakpointRejectedLine", { bg = pink_bg })

  -- === Leap ===
  hi("LeapBackdrop", { fg = subtle })
  hi("LeapMatch", { fg = pink, bold = true })
  hi("LeapLabelPrimary", { fg = p.green_600 })
  hi("LeapLabelSecondary", { fg = p.blue_600 })

  -- === Illuminate ===
  hi("IlluminatedWordText", { bg = float_bg })
  hi("IlluminatedWordRead", { bg = float_bg })
  hi("IlluminatedWordWrite", { bg = float_bg })

  -- === Rainbow Delimiters ===
  hi("RainbowDelimiterYellow", { fg = orange })
  hi("RainbowDelimiterPurple", { fg = purple })
  hi("RainbowDelimiterBlue", { fg = blue })

  -- === Notify ===
  hi("NotifyBackground", { fg = pink_bg, bg = bg })
  hi("NotifyERRORBorder", { fg = pink_bg })
  hi("NotifyWARNBorder", { fg = orange_bg })
  hi("NotifyINFOBorder", { fg = green_bg })
  hi("NotifyDEBUGBorder", { fg = gutter })
  hi("NotifyTRACEBorder", { fg = purple_bg })
  hi("NotifyERRORIcon", { fg = pink })
  hi("NotifyWARNIcon", { fg = orange })
  hi("NotifyINFOIcon", { fg = green })
  hi("NotifyDEBUGIcon", { fg = fg })
  hi("NotifyTRACEIcon", { fg = purple })
  hi("NotifyERRORTitle", { fg = pink })
  hi("NotifyWARNTitle", { fg = orange })
  hi("NotifyINFOTitle", { fg = green })
  hi("NotifyDEBUGTitle", { fg = fg })
  hi("NotifyTRACETitle", { fg = purple })

  -- === Search Lens ===
  hi("HlSearchLens", { fg = gutter })
  hi("HlSearchLensNear", { fg = comment, bold = true })

  -- === Indent ===
  hi("MiniIndentscopeSymbol", { fg = gutter })

  -- === CSS (legacy vim-syntax fallback) ===
  hi("cssClassName", { fg = green })
  hi("cssBraces", { fg = fg })
  hi("cssDefinition", { fg = blue, italic = true })
  hi("cssAnimationProp", { link = "cssDefinition" })
  hi("cssBackgroundProp", { link = "cssDefinition" })
  hi("cssMediaProp", { link = "cssDefinition" })
  hi("cssPositioningProp", { link = "cssDefinition" })
  hi("cssFlexibleBoxProp", { link = "cssDefinition" })
  hi("cssFontProp", { link = "cssDefinition" })
  hi("cssTextProp", { link = "cssDefinition" })
  hi("cssAttrRegion", { fg = turquoise })
  hi("cssFlexibleBoxAttr", { link = "cssAttrRegion" })
  hi("cssMultiColumnAttr", { link = "cssAttrRegion" })
  hi("cssAnimationAttr", { link = "cssAttrRegion" })
  hi("cssTransitionAttr", { link = "cssAttrRegion" })
  hi("cssFunctionName", { fg = turquoise, bold = true })
  hi("cssUnitDecorators", { fg = pink, bold = true })
  hi("cssColor", { fg = purple })

  -- === Treesitter ===
  hi("@constant.builtin", { fg = purple })
  hi("@constructor", { fg = blue })

  hi("@keyword", { fg = pink, bold = true })
  hi("@keyword.function", { fg = blue, bold = true, italic = true })
  hi("@keyword.return", { fg = pink, bold = true })
  hi("@keyword.import", { fg = pink, bold = true })
  hi("@keyword.conditional", { fg = pink, bold = true })
  hi("@keyword.repeat", { fg = pink, bold = true })
  hi("@keyword.exception", { fg = pink, bold = true })
  hi("@keyword.coroutine", { fg = pink, bold = true })
  hi("@keyword.operator", { fg = pink, bold = true })

  hi("@markup.heading", { fg = pink, bold = true })
  hi("@markup.list", { fg = orange, bold = true })
  hi("@markup.italic", { fg = orange, italic = true })
  hi("@markup.strong", { bold = true })
  hi("@markup.link.url", { fg = blue })
  hi("@markup.raw", { fg = turquoise })

  hi("@function.builtin", { fg = turquoise })
  hi("@function.call", { fg = green })
  hi("@function.macro", { fg = green })
  hi("@function.css", { fg = turquoise })

  hi("@property", { fg = fg })
  hi("@property.css", { fg = blue, italic = true })

  hi("@punctuation.bracket", { fg = fg })
  hi("@punctuation.delimiter", { fg = fg })
  hi("@punctuation.special", { fg = pink })

  hi("@operator", { fg = fg })

  hi("@string", { fg = orange })
  hi("@string.documentation", { fg = comment, italic = true })
  hi("@string.escape", { fg = turquoise })
  hi("@string.regexp", { fg = turquoise })

  hi("@tag", { fg = pink })
  hi("@tag.builtin", { fg = pink })
  hi("@tag.attribute", { fg = green })
  hi("@tag.delimiter", { fg = fg })

  hi("@comment.error", { fg = pink, bold = true })
  hi("@comment.todo", { fg = pink, bold = true })
  hi("@comment.warning", { fg = orange, bold = true })
  hi("@comment.note", { fg = blue, bold = true })

  hi("@type", { fg = green })
  hi("@type.definition", { fg = green })
  hi("@type.qualifier", { fg = purple, bold = true })
  hi("@type.builtin", { fg = blue, italic = true })

  hi("@variable", { fg = fg })
  hi("@variable.member", { fg = fg })
  hi("@variable.parameter", { fg = orange, italic = true })
  hi("@variable.builtin", { fg = purple, bold = true })

  hi("@module", { fg = blue })
  hi("@module.builtin", { fg = turquoise })

  hi("@number", { fg = purple })
  hi("@number.float", { fg = purple })
  hi("@boolean", { fg = purple })
  hi("@character", { fg = purple })
  hi("@character.special", { fg = turquoise })

  hi("@attribute", { fg = green })
  hi("@attribute.builtin", { fg = turquoise })
  hi("@label", { fg = pink, bold = true })

  -- === LSP Semantic Tokens ===
  hi("@lsp.type.variable", { fg = fg })
  hi("@lsp.type.property", { fg = fg })
  hi("@lsp.type.member", { fg = green })
  hi("@lsp.type.parameter", { fg = orange })
  hi("@lsp.type.type", { fg = green })
  hi("@lsp.type.class", { fg = green })
  hi("@lsp.type.struct", { fg = green })
  hi("@lsp.type.enum", { fg = green })
  hi("@lsp.type.interface", { fg = blue, italic = true })
  hi("@lsp.type.enumMember", { fg = purple })
  hi("@lsp.type.namespace", { fg = fg })
  hi("@lsp.type.decorator", { fg = green })
  hi("@lsp.type.keyword", { fg = pink, bold = true })
  hi("@lsp.typemod.defaultlibrary", { fg = turquoise })
  hi("@lsp.typemod.function", { fg = green })
  hi("@lsp.typemod.function.defaultLibrary", { fg = turquoise })
  hi("@lsp.typemod.type.defaultLibrary", { fg = blue, italic = true })
  hi("@lsp.typemod.parameter.declaration", { fg = orange, italic = true })
  hi("@lsp.typemod.variable.defaultLibrary", { fg = purple })
  hi("@lsp.typemod.variable.readonly", { fg = purple, bold = true })
  hi("@lsp.typemod.variable.readonly.typescript", { fg = fg, bold = false })
  hi(
    "@lsp.typemod.variable.readonly.typescriptreact",
    { fg = fg, bold = false }
  )
  hi("@lsp.typemod.class.declaration", { fg = green })
end

return { setup = setup }
