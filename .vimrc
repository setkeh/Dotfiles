" Setkeh VIMRC.
"
" Maintainer:	setkeh <setkeh@gmail.com>
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle
" Vundle Plugin Management.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible             " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Plugins.
Plugin 'fatih/vim-go'
Plugin 'vimwiki/vimwiki'
Plugin 'Valloric/YouCompleteMe'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'majutsushi/tagbar'
Plugin 'mattn/gist-vim'
Plugin 'vim-scripts/atom-dark'
Plugin 'scrooloose/syntastic'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'rodjek/vim-puppet'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'rust-lang/rust.vim'
Plugin 'myint/syntastic-extras'
Plugin 'roktas/syntastic-more'
Plugin 'kballard/vim-swift'
Plugin 'mattn/webapi-vim'
Plugin 'tpope/vim-dispatch'
Plugin 'jreybert/vimagit'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" DEFAULTS
" Some Vim Defaults
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
set encoding=utf-8

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"CUSTOM KEYMAPS
"Mapping Custom KeyBinds
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Switch to shell ("exit" returns to vim)
map <s-s> :shell<cr>
"Paste to Gist.Githu.com
map <s-g> :Gist<cr>
"Go Doc Verticle
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
"Go Doc
au FileType go nmap <Leader>gd <Plug>(go-doc)
"Go Info
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>s <Plug>(go-implements)
"Go Def
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)
"Go Commands
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
"Tagbar
nmap <F8> :TagbarToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" INDENT AND TAB-SPACING SETTINGS
" Setup Default Tab and Indent Spacing
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Global vIM defaults
set expandtab "Set tabs to spaces
set tabstop=2 "Set tabs to 2 spaces
set shiftwidth=4 "Set default indentation to 2 spaces

"Filetype Specific Settings
autocmd FileType make setlocal noexpandtab "Dont change Tabs to spaces in Makefiles
autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab "Set Tabs to 4 spaces in python files

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"CUSTOM SETTINGS
"Set Settings Custom
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hlsearch
set number
set autoindent
set backupdir=~/.vim/backup/
set autochdir
"set shell=zsh
colorscheme atom-dark
let g:go_bin_path = expand("/home/setkeh/.gotools")
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
set laststatus=2

"Alrline Settings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1
let g:airline_theme='powerlineish'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Stolen: Destroy All Software <https://github.com/garybernhardt>
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ARROW KEYS ARE UNACCEPTABLE
" Stolen: Destroy All Software <https://github.com/garybernhardt>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BACKSPACEING
" Allow backspacing over everything in insert mode
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FILE MAPPINGS
" File Mappings for custom enviroments and Arduino
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufRead,BufNewFile *.pde set filetype=arduino
au BufRead,BufNewFile *.ino set filetype=arduino

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERD TREE SETTINGS
" Custom Usefull Settings for NERDTree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"autocmd vimenter * NERDTree
"autocmd vimenter * if !argc() | NERDTree | endif
"map <C-n> :NERDTreeToggle<CR>
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom vIM Tab/Window Commands
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set splitbelow
set splitright

" ctrl+h/l tabe previous/next
map <C-H> :tabp<cr>
map <C-L> :tabn<cr>

" ctrl j/k Split pane up/down
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OTHER
" Other Vim Custom / Defaults
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
              \ | wincmd p | diffthis
endif
