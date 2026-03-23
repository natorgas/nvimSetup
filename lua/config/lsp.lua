-- 1. Setup capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- 2. Python Setup (as you had it)
vim.lsp.config.pyright = {
  filetypes = { "python" },
  capabilities = capabilities,
}
vim.lsp.enable("pyright")

-- 3. C++ Setup (clangd) - The New Way
-- clangd needs utf-16 offset encoding to play nice with nvim-cmp
capabilities.offsetEncoding = { "utf-16" }

vim.lsp.config.clangd = {
  capabilities = capabilities,
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=bundled",
    "--function-arg-placeholders",
    "--fallback-style=llvm",
    -- IMPORTANT: This forces clangd to ONLY suggest symbols you have actually included
    "--all-scopes-completion=false",
  },
  init_options = {
    usePlaceholders = true,
    clangdFileStatus = true,
  },
}

vim.lsp.enable("clangd")
