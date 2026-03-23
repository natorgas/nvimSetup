-- Dired mode
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Telescope keymaps
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' }) 
vim.keymap.set('n', '<leader>gf', builtin.live_grep, { desc = 'Telescope live grep' })

-- Turn off highlight after search
vim.keymap.set('n', '<Esc>', ':nohlsearch<CR>', { silent = true })

-- Format textfile according to window size
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "text", "markdown", "gitcommit" },
  callback = function(args)
    vim.keymap.set("n", "<leader>gq", function()
      local width = math.floor(0.8*vim.api.nvim_win_get_width(0))
      vim.opt_local.textwidth = width
      vim.cmd("normal! ggVGgq")
    end, { buffer = args.buf, noremap = true })
  end,
})

-- Yank to clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])

-- Ignore error/warning on this line
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.keymap.set('n', '<leader>ign', function()
      local line = vim.api.nvim_get_current_line()
      if line:find("#") then
        vim.api.nvim_set_current_line(line .. " type: ignore")
      else
        vim.api.nvim_set_current_line(line .. "  # type: ignore")
      end
    end, { buffer = true, desc = "Append # type: ignore to this line" })
  end,
})

-- Template for cpp
vim.keymap.set("n", "<leader>template", function()
  local template = [[#include <bits/stdc++.h>
using namespace std;

int main() {



  return 0;
}
]]
  -- insert at the very top of the buffer
  vim.api.nvim_buf_set_lines(0, 0, 0, false, vim.split(template, "\n"))
end, { desc = "Insert C++ template at top" })

