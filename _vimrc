"" use two double quotes and a space for comments and one double quote without a space for uncommenting.

"" pathogen settings
execute pathogen#infect()

"" this must be first, because it changes other options as a side effect
set nocompatible

"" Go stuff
"" clear filetype flags before changing runtimepath to force Vim to reload them.
"" http://golang.org/misc/vim/readme.txt 
if exists("g:did_load_filetypes")
 filetype off
 filetype plugin indent off
endif
set runtimepath+=$GOROOT/misc/vim " replace $GOROOT with the output of: go env GOROOT
filetype plugin indent on
syntax on

au FileType go nmap <leader>r <Plug>(go-run)

au FileType go nmap <Leader>gd <Plug>(go-doc)

au FileType go nmap <Leader>ds <Plug>(go-def-split)

"" leave out the byte-order-mark at the start of the file
set nobomb

"" enable line numbers
set number

"" set colorcolumn
set colorcolumn=80

"" change the mapleader from \ to ,
let mapleader=","

"" enable neocomplete https://github.com/Shougo/neocomplete.vim
let g:neocomplete#enable_at_startup = 1

"" Color scheme settings. Inactive due to experiment with random schemes
"set background=dark
"colorscheme base16-shapeshifter

"" 256 color support
set t_Co=256

"" use statusline all the time
"" from https://github.com/spf13/spf13-vim/blob/master/.vimrc
if has('statusline')
	set laststatus=2
      	" Broken down into easily includeable segments
      	set statusline=%<%f\    " Filename
      	set statusline+=%w%h%m%r " Options
      	set statusline+=%{fugitive#statusline()} "  Git Hotness
      	set statusline+=\ [%{&ff}/%Y]            " filetype
      	set statusline+=\ [%{getcwd()}]          " current dir
      	set statusline+=%#warningmsg#
        set statusline+=%{SyntasticStatuslineFlag()}
        set statusline+=%*
  	let g:syntastic_enable_signs=1
	set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif

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

"" Turned off for experimental setup above.
"set laststatus=2
"" Useful status information at bottom of screen
"set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P


"" Snippets are separated from the engine. Add this if you want them:
" Plugin 'honza/vim-snippets'

"" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

"" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


"" backups, undos, and swap files
""-----------------------------------------------------------------------------
"" Save your backups to a less annoying place than the current directory.
"" If you have .vim-backup in the current directory, it'll use that.
"" Otherwise it saves it to ~/.vim/backup or . if all else fails.
if isdirectory($HOME . '/.vim/backup') == 0
  silent !mkdir -p ~/.vim/backup >/dev/null 2>&1
endif
set backupdir-=.
set backupdir+=.
set backupdir-=~/
set backupdir^=~/.vim/backup/
set backupdir^=./.vim-backup/
set backup
"" prevent backups from overwriting each other. The naming is weird,
"" since I'm using the 'backupext' variable to append the path.
"" so the file '/home/docwhat/.vimrc' becomes '.vimrc%home%docwhat~'
if has('autocmd')
  autocmd BufWritePre * nested let &backupext = substitute(expand('%:p:h'), '/', '%', 'g') . '~'
endif


if has('macunix')
  set backupskip+=/private/tmp/*
endif

"" save your swp files to a less annoying place than the current directory.
"" if you have .vim-swap in the current directory, it'll use that.
"" otherwise it saves it to ~/.vim/swap, ~/tmp or .
if isdirectory($HOME . '/.vim/swap') == 0
  silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
endif
set directory=./.vim-swap//
set directory+=~/.vim/swap//
set directory+=~/tmp//
set directory+=.

"" viminfo stores the the state of your previous editing session
set viminfo+=n~/.vim/viminfo
set viminfo^=!,h,f0,:100,/100,@100

if exists('+undofile')
  "" undofile - This allows you to use undos after exiting and restarting
  "" This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
  "" :help undo-persistence
  "" This is only present in 7.3+
  if isdirectory($HOME . '/.vim/undo') == 0
    silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
  endif
  set undodir=./.vim-undo//
  set undodir+=~/.vim/undo//
  set undofile
  set undolevels=1000         " maximum number of changes that can be undone
  set undoreload=10000        " maximum number lines to save for undo on a buffer reload
endif

