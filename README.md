## Requirements
- tree-sitter-cli (Check if you have it with `tree-sitter --version`, if you don't, install the package `tree-sitter-cli` with your package manager)
- A C compiler

## How to use
Navigate into `~/.config/` and make sure to back up and then delete your `/nvim` folder, then clone this repository.

Then, without changing folders, run `mv /nvimSetup nvim`
in order to change the folder's name to what nvim expects it to be. After first startup there are some slight formatting issues. I recommend opening a C++ file, 
running `:Lazy update`, closing the file, now you're set.
