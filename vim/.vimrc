" Show vim keystrokes on the right side of the bottom status bar
set showcmd

set tabstop=2
set shiftwidth=2

" Tab navigation
nnoremap [t :tabprevious<CR>
nnoremap ]t :tabnext<CR>
nnoremap <C-t> :tabnew<CR>:Ex<CR>

" Buffer navigation
nnoremap [b :MBEbp<CR>
nnoremap ]b :MBEbn<CR>

" Quickfix navigation
nnoremap [c :cp<CR>
nnoremap ]c :cn<CR>
nnoremap [C :cfirst<CR>
nnoremap ]C :clast<CR>

set number
set wrap

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

fun! SetupCommandAlias(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun
call SetupCommandAlias("vsb", "vert sb")

call plug#begin('~/.vim/plugged')

" Default settings
Plug 'tpope/vim-sensible'

" Appearance and formatting
Plug 'lifepillar/vim-solarized8'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'raimondi/delimitmate'
Plug 'christoomey/vim-system-copy'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-commentary'
Plug 'fholgado/minibufexpl.vim'
" Plug 'yggdroot/indentline'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'timakro/vim-searchant'

" Statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Sign column
Plug 'airblade/vim-gitgutter'
Plug 'kshenoy/vim-signature'

" Language server and autocomplete
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}

" Navigation
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-vinegar'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
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

" lifepillar/vim-solarized8 config
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set background=dark
colorscheme solarized8_flat
" Gets rid of lines between splits (trailing space is intentional)
set fillchars+=vert:\ ,
" Gets rid of dashes in folds and diffs
set fillchars=fold:\ ,
set fillchars+=diff:\ ,
" Fix highlighting of left cols
highlight LineNr      guibg=#073642
highlight FoldColumn  guibg=#073642
highlight Folded      guibg=#073642
highlight EndOfBuffer guifg=#002b36
" Improve diff highlighting
highlight DiffAdd    guibg=#1B412B guifg=NONE
highlight DiffChange guibg=#4D521E guifg=NONE
highlight DiffDelete guibg=#582E33 guifg=NONE
highlight DiffText   guibg=#083E55 guifg=NONE
" Hide ~s on lines below EOF
highlight EndOfBuffer guifg=#002b36

" ntpeters/vim-better-whitespace config
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0
let g:better_whitespace_guicolor='#4D521E'
let g:better_whitespace_filetypes_blacklist=['diff', 'gitcommit', 'unite', 'qf', 'help', 'markdown', 'vim']

" fholgado/minibufexpl.vim config
let g:miniBufExplSplitBelow = 0
let g:miniBufExplBuffersNeeded = 1
hi MBENormal               guifg=#586e75 guibg=#002b36
hi MBEChanged              guifg=#dc322f guibg=#002b36
hi MBEVisibleNormal        guifg=#268bd2 guibg=#002b36
hi MBEVisibleChanged       guifg=#b58900 guibg=#002b36
hi MBEVisibleActiveNormal  guifg=#002b36 guibg=#268bd2
hi MBEVisibleActiveChanged guifg=#002b36 guibg=#b58900

" vim-airline/vim-airline config
let g:airline_powerline_fonts = 1

" vim-airline/vim-airline-themes config
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'

" yggdroot/indentline config
let g:indentLine_char = '▏'
let g:indentLine_color_gui = '#073642'

" junegunn/rainbow_parentheses.vim config
autocmd VimEnter * RainbowParentheses

" timakro/vim-searchant config
highlight SearchCurrent guifg=#002b36 guibg=#268bd2

" airblade/vim-gitgutter config
let g:gitgutter_grep='ag'
let g:gitgutter_max_signs = 1000
nmap [h <Plug>GitGutterPrevHunk
nmap ]h <Plug>GitGutterNextHunk
" Fixes issue where signs are slow to update
set updatetime=100
highlight SignColumn            guibg=#073642
highlight GitGutterAdd          guifg=#859900 guibg=#073642
highlight GitGutterChange       guifg=#b58900 guibg=#073642
highlight GitGutterDelete       guifg=#dc322f guibg=#073642
highlight GitGutterChangeDelete guifg=#cb4b16 guibg=#073642

" easymotion/vim-easymotion config
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
map <Space> <Plug>(easymotion-bd-f)
nmap <Space> <Plug>(easymotion-overwin-f)
hi link EasyMotionTarget Search
hi link EasyMotionTarget2First Search
hi link EasyMotionTarget2Second Search
hi link EasyMotionShade Comment

" junegunn/fzf config
let $FZF_DEFAULT_OPTS = '--bind ctrl-a:toggle-all'
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction
let g:fzf_action = {
  \ 'ctrl-c': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
nnoremap <Leader>s :Ag<Space>
vnoremap <Leader>s y:Ag <C-R>"<CR>
hi QuickFixLine guifg=#002b36 guibg=#268bd2

" pangloss/vim-javascript config
" Enable concealing within vim
set conceallevel=1

" elzr/vim-json config
" Don't conceal double quotes in json files (concealing makes it difficult to copy)
let g:vim_json_syntax_conceal=0

