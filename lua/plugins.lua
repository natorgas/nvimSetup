return {

-- Colorscheme
-- Colorscheme
{
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    flavour = "latte",
    show_end_of_buffer = true,
    term_colors = false,

    -- Tree-sitter integration is already enabled
    integrations = { treesitter = true },

    -- Custom highlights
    custom_highlights = function(colors)
      return {
        ["@keyword.return"]   = { fg = "#FF0000" },  -- return
        ["@preproc_include"]  = { fg = "#000000" },  -- include
        ["@preproc"]  = { fg = "#000000" },  -- include
        ["@keyword.conditional"] = { fg = "#FF0000" },  -- if 
        ["@keyword.repeat"] = { fg = "#FF0000" },  -- while/for
        ["@keyword.function"] = { fg = "#000000" },  -- function keywords
        ["@type.builtin"]     = { fg = "#FF0000" },  -- int, char, float
        ["@conditional"]      = { fg = "#FF0000" },  -- if, else, while, switch
        ["@parameter"]        = { fg = "#000000" },  -- function arguments
        ["@function"]        = { fg = "#000000" },  -- function 
        ["@function.call"]        = { fg = "#000000" },  -- function 
        ["@function.method.call"]        = { fg = "#000000" },  -- function 
        ["@string"]        = { fg = "#00CC00" },  -- string
        ["@variable"]        = { fg = "#000000" },  -- string
        ["@type"]        = { fg = "#000000" },  -- string
        ["@operator"]        = { fg = "#757575" },  -- string
        ["@variable.parameter"] = { fg = "#000000" }, -- function arguments in definitions
        ["@keyword"]          = { fg = "#FF0000" },  -- if, while, etc
        ["@number"]          = { fg = "#9C27B0" },  -- if, while, etc
        ["@module"]   = { fg = "#000000", style = { "default" }, },  -- return

        Normal = { bg = "#FFFFFF" },

      }
    end,
  },
},

-- Telescope
{
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('telescope').setup{
      defaults = {
        file_ignore_patterns = {
          "__pycache__",
          "%.pyc",
          "%.o",
          "node_modules",
          ".git/",
          "build/",
        }
      }
    }
  end
},

{
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = { "python", "cpp", "c", "lua", "json" },
      highlight = { enable = true, additional_vim_regex_highlighting = false },
      playground = {
        enable = true,
        persist_queries = false,
        updatetime = 25,
        disable = {}
      },
    }
  end,
},

-- lazy-load playground when you run its commands
{
  "nvim-treesitter/playground",
  cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
},

{
  --"windwp/nvim-autopairs",
  --event = "InsertEnter",
  -- config = function()
    -- require("nvim-autopairs").setup({
      -- map_cr = true,
    -- })
  -- end,
},

-- LSP Setup --------------------------------------------------
{
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-buffer'},
      {'L3MON4D3/LuaSnip'},
      {'saadparwaiz1/cmp_luasnip'},
    },

    config = function()
      local lsp_zero = require('lsp-zero')

      -- Automatically sets up keymaps (like 'gd' to go to definition) when a server attaches
      lsp_zero.on_attach(function(client, bufnr)
        lsp_zero.default_keymaps({buffer = bufnr})
      end)

      -- Setup Mason and tell it to manage our language servers
      require('mason').setup({})
      require('mason-lspconfig').setup({
        ensure_installed = {'clangd', 'pyright'}, -- Automatically installs C++ and Python servers
        handlers = {
          lsp_zero.default_setup,
        },
      })

      -- LuaSnip Custom Snippets
      local ls = require('luasnip')
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node

      ------------------------------------------- CUSTOM AUTOCOMPLETE SNIPPETS ------------------------

      -- Build our custom C++ for-loop
      ls.add_snippets("cpp", {
        s("for", {
          t("for ("),
          i(1),            -- Cursor lands right here when you hit Tab
          t(") {"),
          t({ "", "}" }), -- Adds a newline and 2 spaces of indent
        })
      })

      ------------------------------------------- CUSTOM AUTOCOMPLETE SNIPPETS ------------------------

      local cmp = require('cmp')
      cmp.setup({

        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },

        mapping = cmp.mapping.preset.insert({
          -- 'select = true' automatically selects the first item if you haven't scrolled
          ['<Tab>'] = cmp.mapping.confirm({ select = true }),
        }),

        -- This limits the overall window size to 10 items
        performance = {
          max_view_entries = 10, 
        },
        -- Limit how many suggestions come from each specific source
        sources = {
          { name = 'luasnip', max_item_count = 3},
          { name = 'nvim_lsp', max_item_count = 3},
          { name = 'buffer', max_item_count = 3 },
        }
      })

    end
  }
}
-------------------------------------------------------------------------

}
