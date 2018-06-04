set tabstop=4
set shiftwidth=4

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Solve issue with yanking not working for more than ~50 lines
:set viminfo='100,<1000,s100,h

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'raimondi/delimitmate'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'vim-scripts/Better-Javascript-Indentation'

call plug#end()

" scrooloose/nerdtree config
map <C-o> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
" open NERDTree automatically when vim starts up w/ no specified files
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" open NERDTree automatically when vim starts up on opening a dir
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" close vim if only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" pangloss/vim-javascript config
" Enable concealing within VIM (used for pangloss/vim-javascript)
set conceallevel=1
let g:javascript_conceal_function = 'f'

" leafgarland/typescript-vim config
" disable indenter since it doesn't seem to work properly (maybe when it's
" combined with pangloss/vim-javascript)
let g:typescript_indent_disable = 1

