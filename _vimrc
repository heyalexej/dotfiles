"" Pathogen execution as per https://github.com/tpope/vim-pathogen
execute pathogen#infect()

set rtp+=/usr/local/lib/python3.4/dist-packages/powerline/bindings/vim/

"" Always show statusline
set laststatus=2

"" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

"" Set line numbers
set nu

"" Activate Python Highlighting as per https://github.com/hdima/python-syntax
let python_highlight_all = 1

"" Better git commit messages as per http://web-design-weekly.com/blog/2013/09/01/a-better-git-commit/
syntax on
filetype indent plugin on
autocmd Filetype gitcommit spell textwidth=72
