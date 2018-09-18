let mapleader=' '

set tabstop=2
set shiftwidth=2

:nnoremap <C-J> <C-W><C-J>
:nnoremap <C-K> <C-W><C-K>
:nnoremap <C-L> <C-W><C-L>
:nnoremap <C-H> <C-W><C-H>

set splitbelow
set splitright

" Make vim scroll when cursor moves closer than 4 lines from top or bottom
set scrolloff=4

" Mute vim
set noeb vb t_vb=

" Reduce visual lag
set ttyfast
set lazyredraw

" Solve issue with yanking not working for more than ~50 lines
set viminfo='100,<1000,s100,h

" Open all folds by default (some files have a ton of folds and are impossible
" to read without opening all folds with zr
autocmd VimEnter * execute "normal! zr"

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'christoomey/vim-system-copy'
Plug 'tpope/vim-surround'
Plug 'raimondi/delimitmate'
Plug 'tpope/vim-sleuth'
Plug 'easymotion/vim-easymotion'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'airblade/vim-gitgutter'
Plug 'kshenoy/vim-signature'
" Plug 'tpope/vim-fugitive'
" Plug 'junegunn/gv.vim'
Plug 'mileszs/ack.vim'
Plug 'garbas/vim-snipmate'
Plug 'w0rp/ale'
Plug 'ervandew/supertab'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'vim-scripts/Better-Javascript-Indentation'
Plug 'elzr/vim-json'
" Plug 'mhinz/vim-startify'
Plug 'tpope/vim-obsession'
" Plug 'roman/golden-ratio'
Plug 'justincampbell/vim-eighties'
Plug 't9md/vim-choosewin'
Plug 'romgrk/winteract.vim'
Plug 'joukevandermaas/vim-ember-hbs'

call plug#end()

" altercation/vim-colors-solarized
syntax enable
let g:solarized_use16 = 1
set background=dark
colorscheme solarized

" vim-airline/vim-airline config
let g:airline_powerline_fonts = 1

" vim-airline/vim-airline-themes config
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'

" scrooloose/nerdtree config
noremap <leader>o :NERDTreeToggle<CR>
noremap <leader>p :NERDTreeFind<CR>
let NERDTreeShowHidden = 1
autocmd StdinReadPre * let s:std_in=1
" " open NERDTree automatically when vim starts up w/ no specified files
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" open NERDTree automatically when vim starts up on opening a dir
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" close vim if only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" easymotion/vim-easymotion config
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
map <Leader>s <Plug>(easymotion-bd-f)
nmap <Leader>s <Plug>(easymotion-overwin-f)
map <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)
map <Leader>l <Plug>(easymotion-bd-jk)
nmap <Leader>l <Plug>(easymotion-overwin-line)

" ctrlpvim/ctrlp.vim config
nmap <C-B> :CtrlPBuffer<CR>
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  " let g:ctrlp_use_caching = 0
endif

" kshenoy/vim-signature config
" let g:SignatureMarkTextHL = 1

" " tpope/vim-fugitive & junegunn/gv.vim config
" noremap <leader>g :GV!<CR>

" mileszs/ack.vim config
cnoreabbrev Ack Ack!
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" garbas/vim-snipmate config
" map <C-i> <Plug>snipMateNextOrTrigger

" w0rp/ale config
" nmap <silent> <C-n> <Plug>(ale_previous_wrap)
" nmap <silent> <C-m> <Plug>(ale_next_wrap)
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
map <leader>f <Plug>(ale_fix)
let g:ale_fixers = {
\   'javascript': ['eslint', 'prettier'],
\   'typescript': ['eslint', 'prettier'],
\}
let g:ale_javascript_prettier_options = '--print-width 80 --single-quote --trailing-comma "es5"'
let g:ale_javascript_prettier_use_local_config = 1

" pangloss/vim-javascript config
" Enable concealing within VIM (used for pangloss/vim-javascript)
set conceallevel=1

" elzr/vim-json config
" Don't conceal double quotes in json files (concealing makes it difficult to copy)
let g:vim_json_syntax_conceal=0

" t9md/vim-choosewin config
map <C-n> <Plug>(choosewin)
let g:choosewin_overlay_enable = 1

" romgrk/winteract.vim config
map <C-w> :InteractiveWindow<CR>

