"" Pathogen execution as per https://github.com/tpope/vim-pathogen
execute pathogen#infect()

"" Required by https://github.com/suan/vim-instant-markdown#installation
filetype plugin on

set rtp+=/usr/local/lib/python3.4/dist-packages/powerline/bindings/vim/

"" Always show statusline
set laststatus=2

"" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

"" Set line numbers
set nu

"" Activate Python Highlighting as per https://github.com/hdima/python-syntax
let python_highlight_all = 1

"" Better git commit messages as per
"" http://stopwritingramblingcommitmessages.com/
"" http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
"" http://web-design-weekly.com/blog/2013/09/01/a-better-git-commit/
syntax on
filetype indent plugin on
autocmd Filetype gitcommit spell textwidth=72

"" Set colorcolumn to 80 chars, or (if not supported) highlight lines > 80 chars
"" http://stackoverflow.com/q/11812615 
"" http://stackoverflow.com/a/13731714
augroup ColorColumnConfig
set background=light
   au!
   if exists('+colorcolumn')
""      au BufWinEnter * set colorcolumn=80
""      au BufWinEnter * hi ColorColumn
      au BufWinEnter * let &colorcolumn="80,".join(range(120,999),",")
      au BufWinEnter * hi ColorColumn term=bold ctermbg=0
   else
      au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
   endif
augroup END

set guifont=Ubuntu\ Mono\ 8.4
