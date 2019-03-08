" Show vim keystrokes on the right side of the bottom status bar
set showcmd

set tabstop=2
set shiftwidth=2

" Tab navigation
nnoremap [t :tabprevious<CR>
nnoremap ]t :tabnext<CR>
nnoremap <C-t> :tabnew<CR>:Ex<CR>

" Buffer navigation
nnoremap [b :bp<CR>
nnoremap ]b :bn<CR>

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

" Maintain undo history between sessions
" If persistent undo isn't working it might be because ~/.vim/undo hasn't been
" created yet
set undofile
set undodir=~/.vim/undo
" Put swp files in their own directory
set directory=$HOME/.vim/swp//

" " Open netrw automatically when vim starts up w/ no specified files
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | execute "normal! -" | endif
" Open netrw automatically when vim starts up on opening a dir
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | execute "normal! -" | endif

call plug#begin('~/.vim/plugged')

" Default settings
Plug 'tpope/vim-sensible'

" Appearance and formatting
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'raimondi/delimitmate'
Plug 'christoomey/vim-system-copy'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-commentary'
Plug 'timakro/vim-searchant'

" Statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Sign column
Plug 'airblade/vim-gitgutter'
Plug 'kshenoy/vim-signature'

" Language server and autocomplete
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

" Navigation
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-vinegar'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'
Plug 't9md/vim-choosewin'
Plug 'christoomey/vim-tmux-navigator'

" Snippets (see ~/.vim/minisnip)
Plug 'joereynolds/vim-minisnip'

" Git
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

" Sessions
Plug 'tpope/vim-obsession'

" Language specific
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'vim-scripts/Better-Javascript-Indentation'
Plug 'elzr/vim-json'
Plug 'joukevandermaas/vim-ember-hbs'

call plug#end()

" altercation/vim-colors-solarized config
syntax enable
set t_Co=256
let g:solarized_use16 = 1
set background=dark
colorscheme solarized

" ntpeters/vim-better-whitespace config
let g:strip_whitespace_on_save=1

" vim-airline/vim-airline config
let g:airline_powerline_fonts = 1

" vim-airline/vim-airline-themes config
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'

" airblade/vim-gitgutter config
let g:gitgutter_grep='ag'
let g:gitgutter_max_signs = 1000

" prabirshrestha/vim-lsp config
let g:lsp_async_completion = 1
set omnifunc=lsp#complete
if executable('typescript-language-server')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'javascript-typescript-language-server',
    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
    \ 'whitelist': ['javascript', 'javascript.jsx', 'typescript', 'typescript.tsx'],
  \ })
endif
if executable('go-langserver')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'go-langserver',
    \ 'cmd': {server_info->['go-langserver', '-gocodecompletion']},
    \ 'whitelist': ['go'],
  \ })
endif

" easymotion/vim-easymotion config
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
map <Space> <Plug>(easymotion-bd-f)
nmap <Space> <Plug>(easymotion-overwin-f)
hi link EasyMotionTarget Search
hi link EasyMotionTarget2First Search
hi link EasyMotionTarget2Second Search
hi link EasyMotionShade Comment

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

" mileszs/ack.vim config
cnoreabbrev Ack Ack!
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" t9md/vim-choosewin config
map <C-n> <Plug>(choosewin)
let g:choosewin_overlay_enable = 1

" pangloss/vim-javascript config
" Enable concealing within vim
set conceallevel=1

" elzr/vim-json config
" Don't conceal double quotes in json files (concealing makes it difficult to copy)
let g:vim_json_syntax_conceal=0

