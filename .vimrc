execute "set tags+=./tags"
execute "set tags+=/wine/tags"
execute "set tags+=/trunk/tags"
set nu
set ic "ignore case
set tabstop=2 shiftwidth=2 expandtab
set shiftwidth=2
set hlsearch
set incsearch
"hi Search ctermbg=LightYellow
hi Search ctermfg=Red
call plug#begin('~/.vim/plugged')
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
"Plug 'funorpain/vim-cpplint'
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'ctrlpvim/ctrlp.vim'
"Plug 'airblade/vim-rooter'
Plug 'airblade/vim-gitgutter'
"Plug 'scrooloose/syntastic'
"Plug 'Rip-Rip/clang_complete'
"Plug 'ctrlpvim/ctrlp.vim'
"Plug 'nanotech/jellybeans.vim'
"Plug 'flazz/vim-colorschemes'
Plug 'majutsushi/tagbar' 
"Plug 'Yggdroot/indentLine'
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
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
call plug#end()

set clipboard=unnamed "use OS clipboard

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

if executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'allowlist': ['python'],
        \ })
endif

if executable('clangd')
    augroup lsp_clangd
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'clangd',
                    \ 'cmd': {server_info->['clangd']},
                    \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
                    \ })
        autocmd FileType c setlocal omnifunc=lsp#complete
        autocmd FileType cpp setlocal omnifunc=lsp#complete
        autocmd FileType objc setlocal omnifunc=lsp#complete
        autocmd FileType objcpp setlocal omnifunc=lsp#complete
    augroup end
endif

"if executable('rust-analyzer')
"  au
"
"endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nmap <buffer> gl <plug>(lsp-document-diagnostics)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END




"autocomplete configuration

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
imap <c-space> <Plug>(asyncomplete_force_refresh)
" For Vim 8 (<c-@> corresponds to <c-space>):
imap <c-@> <Plug>(asyncomplete_force_refresh)
