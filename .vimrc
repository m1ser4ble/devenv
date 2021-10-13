execute "set tags+=./tags"
execute "set tags+=/wine/tags"
execute "set tags+=/trunk/tags"
set nu
set ic "ignore case
set ts=2
set shiftwidth=2
set hlsearch
set incsearch
"hi Search ctermbg=LightYellow
hi Search ctermfg=Red
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'ctrlpvim/ctrlp.vim'
"Plug 'airblade/vim-rooter'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/syntastic'
"Plug 'Rip-Rip/clang_complete'
"Plug 'ctrlpvim/ctrlp.vim'
"Plug 'nanotech/jellybeans.vim'
"Plug 'flazz/vim-colorschemes'
Plug 'majutsushi/tagbar' 
Plug 'Yggdroot/indentLine'
Plug 'yegappan/mru'
Plug 'vim-scripts/Mark--Karkat'
Plug 'tomasiser/vim-code-dark'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'bronson/vim-trailing-whitespace'
"Plug 'vim-scripts/OmniCppComplete'
"Plug 'Valloric/YouCompleteMe'
"Plug 'kchmck/vim-coffee-script'
call plug#end()


let g:nerdpath=expand('%:p:h')

map <Leader>t <ESC>:let g:nerdpath=expand('%:p:h')<CR>:execute "NERDTree "g:nerdpath<CR>
map <Leader>ru <ESC>:MRU<CR>
map <Leader>p <ESC>:CtrlP pwd<CR>
map <Leader>tt <ESC>:TagbarToggle<CR>
let OmniCpp_ShowPrototypeInAbbr=0

"let g:clang_library_path='/usr/lib/llvm-4.0/lib/libclang.so.1'
"let g:airline_section_c .= 'hello'
" Syntax Highlighting
if has("syntax")
	syntax on
endif


"set autoindent
"set cindent
"colors visualstudio
"colorscheme jellybeans
colors codedark

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
