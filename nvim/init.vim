" Plugins
call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'klen/python-mode'
Plug 'christoomey/vim-tmux-navigator'
Plug 'luochen1990/rainbow'
Plug 'jiangmiao/auto-pairs'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'micha/vim-colors-solarized'
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'
Plug 'vim-scripts/taglist.vim'
Plug 'mileszs/ack.vim'
Plug 'keith/swift.vim'
Plug 'pangloss/vim-javascript'
Plug 'tikhomirov/vim-glsl'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'edkolev/tmuxline.vim'
call plug#end()

" Non plugin stuff
syntax on
set encoding=utf-8

" Remap leader
let mapleader = ','

" Make config files look nicer
au BufRead,BufNewFile *.config setfiletype dosini

" Spell Check
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd BufRead,BufNewFile *.feature setlocal spell
autocmd FileType gitcommit setlocal spell

" Make fontend stuff look nice
au BufNewFile,BufRead *.html
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |

" Don't show pyc files in NERDTree
let NERDTreeIgnore=['\.pyc$', '\~$', '\.o$', '\.egg$', '\.egg-info$']

" Code Folding Stuff
set foldmethod=indent
set foldlevel=99
nnoremap <space> za

" Allow copy to clipboard
set clipboard=unnamed

" Easier Split Navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"Python support
augroup vimrc_autocmds
    autocmd!
    " highlight characters past column 80
    autocmd FileType python highlight Excess ctermbg=Black guibg=Black
    autocmd FileType python match Excess /\%81v.*/
    autocmd FileType python set nowrap
    augroup END

"Make the color column look decent
highlight ColorColumn ctermbg=234 guibg=#2c2d27

let g:pymode_rope = 0

" pymode-completion
let g:pymode_rope_completion = 0

" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

"Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
" Auto check on save
let g:pymode_lint_write = 1

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>b'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 0

" Pefer spaces to tabs
set tabstop=4
set shiftwidth=4
set expandtab

" TagList Plugin Configuration
let Tlist_Ctags_Cmd='ctags'
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 0
let Tlist_Use_Right_Window = 1
let Tlist_File_Fold_Auto_Close = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_Use_Right_Window = 1
map <leader>t :TlistToggle<CR>

if has ('gui_running')
    colorscheme blackboard
    " more subtle popup colors 
    highlight Pmenu guibg=#000000 gui=bold    
else
    highlight Pmenu ctermfg=232 ctermbg=238
endif

" Softer diff colors
highlight DiffAdd       cterm=bold ctermfg=10   ctermbg=237
highlight DiffDelete    cterm=bold ctermfg=237  ctermbg=237
highlight DiffChange    cterm=bold ctermfg=10   ctermbg=237
highlight DiffText      cterm=bold ctermfg=10   ctermbg=234

" Softer divider colors
highlight VertSplit     cterm=bold ctermfg=237  ctermbg=237

" Easily toggle nerdTree
nmap <leader>ne :NERDTree<cr>


" Have Ack use Silver Seacher if it's available
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Visual mode colors
hi Visual term=reverse cterm=reverse ctermbg=237

" Turn on rainbow parens
let g:rainbow_active = 1

" Transform Splits
noremap <Leader>H <c-w>t<c-w>K<cr>
noremap <Leader>V <c-w>t<c-w>H<cr>

" Default to command mode when losing focus
au FocusLost,TabLeave * call feedkeys("\<C-\>\<C-n>")

" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" Nerd tree font
let g:NERDTreeGitStatusUseNerdFonts = 1

" dark mode!
let &t_Co=16
set background=dark
colorscheme solarized

" Fix backspace
set backspace=indent,eol,start

" Map  Autoformatting
nmap <leader>f  <Plug>(coc-format)
nmap <silent> gd <Plug>(coc-definition)

execute "normal Tmuxline vim_statusline_3"

