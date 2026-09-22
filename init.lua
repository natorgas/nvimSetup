vim.g.maplocalleader = " " 
vim.g.mapleader = " "

-- Fix Treesitter parser path
vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/site")

vim.filetype.add({
  extension = {
    ptx = "xml",
  },
})

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

vim.opt.showmode = false

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

-- Disable Kitty Keyboard Protocol (breaks keyd-synthesized <Esc> in Konsole)
--
-- Nvim only enables the protocol *after* the terminal replies to its startup
-- query, so hooking UIEnter alone is a race: when the reply lands late, nvim
-- pushes the protocol back on and <Esc> stops working. TermResponse fires on
-- that reply, and the deferred pop is guaranteed to land after nvim's push.
-- Note: nvim_ui_send writes through nvim's own output buffer; io.stdout
-- bypasses it and can be reordered against nvim's own sequences.
local function disable_kitty_keyboard()
  pcall(vim.api.nvim_ui_send, "\27[<u")
end

vim.api.nvim_create_autocmd("UIEnter", {
  once = true,
  callback = disable_kitty_keyboard,
})

vim.api.nvim_create_autocmd("TermResponse", {
  callback = function()
    vim.schedule(disable_kitty_keyboard)
    vim.defer_fn(disable_kitty_keyboard, 50)
  end,
})

