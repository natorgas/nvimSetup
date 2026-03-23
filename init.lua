vim.g.maplocalleader = " " 
vim.g.mapleader = " "

-- Load plugins
require("config.lazy")

-- Load remaps
require("keymaps")

-- Load lspconfig
-- require("config.lsp")

-- Line numbers and relative lines
vim.opt.number = true
vim.opt.relativenumber = true
  
-- Make indentation work
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.smartindent = true

-- Insert cursor: block
vim.opt.guicursor = ""

-- Set colorscheme
vim.cmd("colorscheme catppuccin")

-- Scrolloff
vim.opt.scrolloff = 8


-- Format text when window size is changed -----------------------------------

vim.api.nvim_create_augroup("MyWindowResizing", { clear = true })

vim.api.nvim_create_autocmd("VimResized", {
  group = "MyWindowResizing",
  callback = function()
    local ft = vim.bo.filetype
    if ft == "text" or ft == "markdown" or ft == "gitcommit" then
      local width = math.floor(0.8*vim.api.nvim_win_get_width(0))
      vim.opt_local.textwidth = width
      vim.cmd("normal! ggVGgq")
    end
  end,
  desc = "Automatically adjust textwidth and reformat on window resize",
})

------------------------------------------------------------------------------

-- Automatically write when needed
vim.o.autowrite = true

-- Automatically save all buffers when leaving Neovim
vim.api.nvim_create_autocmd("FocusLost", {
  pattern = "*",
  command = "wa",
})

