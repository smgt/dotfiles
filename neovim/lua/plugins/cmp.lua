local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- require("copilot_cmp").setup()

local luasnip = require("luasnip")
local cmp = require("cmp")

require("luasnip.loaders.from_snipmate").lazy_load()

--local lspkind_status_ok, lspkind = pcall(require, "lspkind")
--if not lspkind_status_ok then
--	return
--end

--lspkind.init({
--	-- defines how annotations are shown
--	-- default: symbol
--	-- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
--	mode = "text_symbol",

--	-- default symbol map
--	-- can be either 'default' (requires nerd-fonts font) or
--	-- 'codicons' for codicon preset (requires vscode-codicons font)
--	--
--	-- default: 'default'
--	preset = "default",

--	-- override preset symbols
--	--
--	-- default: {}
--	symbol_map = {
--		Copilot = "",
--		Text = "",
--		Method = "",
--		Function = "",
--		Constructor = "",
--		Field = "ﰠ",
--		Variable = "",
--		Class = "ﴯ",
--		Interface = "",
--		Module = "",
--		Property = "ﰠ",
--		Unit = "塞",
--		Value = "",
--		Enum = "",
--		Keyword = "",
--		Snippet = "",
--		Color = "",
--		File = "",
--		Reference = "",
--		Folder = "",
--		EnumMember = "",
--		Constant = "",
--		Struct = "פּ",
--		Event = "",
--		Operator = "",
--		TypeParameter = "",
--	},
--})

-- local copilot_comparators = require("copilot_cmp.comparators")
--

local lspkind = require("lspkind")

cmp.setup({
  -- preselect = cmp.PreselectMode.None,
  -- experimental = {
  --   ghost_text = false -- this feature conflict with copilot preview
  -- },
  -- confirmation = {
  --   get_commit_characters = function(_commit_characters)
  --     return {}
  --   end
  -- },
  -- sorting = {
  -- 	priority_weight = 2,
  -- 	comparators = {
  -- 		copilot_comparators.prioritize,
  -- 		-- require("copilot_cmp.comparators").score,

  -- 		-- Below is the default comparitor list and order for nvim-cmp
  -- 		cmp.config.compare.offset,
  -- 		-- cmp.config.compare.scopes, --this is commented in nvim-cmp too
  -- 		cmp.config.compare.exact,
  -- 		cmp.config.compare.score,
  -- 		cmp.config.compare.recently_used,
  -- 		cmp.config.compare.locality,
  -- 		cmp.config.compare.kind,
  -- 		cmp.config.compare.sort_text,
  -- 		cmp.config.compare.length,
  -- 		cmp.config.compare.order,
  -- 	},
  -- },
  enabled = function()
    -- disable completion in comments
    local context = require("cmp.config.context")
    -- keep command mode completion enabled when cursor is in a comment
    if vim.api.nvim_get_mode().mode == "c" then
      return true
    else
      return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
    end
  end,
  window = {
    documentation = cmp.config.window.bordered(),
    -- completion = cmp.config.window.bordered(),
    completion = {
      winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
      col_offset = -3,
      side_padding = 0,
    },
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
      local strings = vim.split(kind.kind, "%s", { trimempty = true })
      kind.kind = " " .. (strings[1] or "") .. " "
      kind.menu = "    (" .. (strings[2] or "") .. ")"

      return kind
    end,
  },
  -- formatting = {
  --   format = lspkind.cmp_format({
  --     mode = "symbol_text",
  --     maxwidth = 50,
  --     ellipsis_char = "...",
  --     -- menu = {
  --     --   buffer = "[Buffer]",
  --     --   nvim_lsp = "[LSP]",
  --     --   luasnip = "[LuaSnip]",
  --     --   nvim_lua = "[Lua]",
  --     --   latex_symbols = "[Latex]",
  --     -- },
  --   }),
  -- },
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
    end,
  },
  mapping = {
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    -- ["<C-g>"] = cmp.mapping(function()
    -- 	vim.api.nvim_feedkeys(
    -- 		vim.fn["copilot#Accept"](vim.api.nvim_replace_termcodes("<Tab>", true, true, true)),
    -- 		"n",
    -- 		true
    -- 	)
    -- end),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = cmp.config.sources({
    -- { name = "copilot" },
    { name = "nvim_lsp_signature_help" },
    { name = "luasnip" }, -- For luasnip users.
    { name = "nvim_lsp" },
  }, {
    { name = "buffer" },
  }),
  experimental = { ghost_text = true },
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "buffer" },
  }),
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})

cmp.setup.filetype("gitcommit", {
  sources = cmp.config.sources({
    { name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = "buffer" },
  }),
})

-- Customization for Pmenu
vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#282C34", fg = "NONE" })
vim.api.nvim_set_hl(0, "Pmenu", { fg = "#C5CDD9", bg = "#22252A" })

vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#7E8294", bg = "NONE", strikethrough = true })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#82AAFF", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#82AAFF", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#C792EA", bg = "NONE", italic = true })

vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = "#EED8DA", bg = "#B5585F" })
vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = "#EED8DA", bg = "#B5585F" })
vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = "#EED8DA", bg = "#B5585F" })

vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#C3E88D", bg = "#9FBD73" })
vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = "#C3E88D", bg = "#9FBD73" })
vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#C3E88D", bg = "#9FBD73" })

vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = "#FFE082", bg = "#D4BB6C" })
vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = "#FFE082", bg = "#D4BB6C" })
vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = "#FFE082", bg = "#D4BB6C" })

vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#EADFF0", bg = "#A377BF" })
vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = "#EADFF0", bg = "#A377BF" })
vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = "#EADFF0", bg = "#A377BF" })
vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = "#EADFF0", bg = "#A377BF" })
vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = "#EADFF0", bg = "#A377BF" })

vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#C5CDD9", bg = "#7E8294" })
vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = "#C5CDD9", bg = "#7E8294" })

vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = "#F5EBD9", bg = "#D4A959" })
vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = "#F5EBD9", bg = "#D4A959" })
vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = "#F5EBD9", bg = "#D4A959" })

vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#DDE5F5", bg = "#6C8ED4" })
vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = "#DDE5F5", bg = "#6C8ED4" })
vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = "#DDE5F5", bg = "#6C8ED4" })

vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = "#D8EEEB", bg = "#58B5A8" })
vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = "#D8EEEB", bg = "#58B5A8" })
vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = "#D8EEEB", bg = "#58B5A8" })
