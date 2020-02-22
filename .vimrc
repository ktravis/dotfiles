" Plugins
call plug#begin('~/.vim/plugged')

Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'SirVer/ultisnips'
Plug 'airblade/vim-gitgutter'
Plug 'bcicen/vim-vice'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'fatih/vim-go'
Plug 'honza/vim-snippets'
Plug 'itchyny/lightline.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'neoclide/coc.nvim', {'do': '~/.npm/bin/yarn install --frozen-lockfile'}
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'

call plug#end()

set autowrite

" Settings --------------------------------------------------- {{{

syntax on

let g:lightline = {}

let g:lightline.colorscheme = 'vice'

let NERDTreeIgnore=['\~$', '\.pyc', '\.swp$', '\.git', '\.hg', '\.svn',
      \ '\.ropeproject', '\.o$', '\.bzr', '\.ipynb_checkpoints$',
      \ '__pycache__',
      \ '\.egg$', '\.egg-info$', '\.tox$', '\.idea$', '\.sass-cache',
      \ '\.coverage$', '\.tmp$', '\.gitkeep$',
      \ '\.coverage$', '\.webassets-cache$', '\.vagrant$', '\.DS_Store',
      \ '\.env-pypy$']

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

set number
set nocompatible
set wrap                " for long lines
set textwidth=80        " #
set formatoptions=jqrn1 " #
set scrolloff=3
set showmode
set showcmd
set hidden
set expandtab
set autoindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set viminfo='10,\"100,:20,%,n$HOME/.vim/.viminfo
set splitright
set splitbelow
set encoding=utf-8
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮

set noswapfile

set backup
set backupdir=$HOME/.vim/backup//

set undofile
set undodir=$HOME/.vim/undo//
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

set ignorecase
set smartcase
set gdefault  " :%s/foo/bar/ instead of :%s/foo/bar/g
set incsearch " highlight search stuff
set showmatch " #
set hlsearch  " #

set wildmenu
set wildmode=list:longest

" Color settings ------------------------------------------ {{{

colorscheme vice

set t_Co=256
set bg=dark
set termguicolors

" }}}

" gvim settings ------------------------------------------ {{{

set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L
set guifont=Inconsolata\ Bold\ 12

" }}}

" }}}

" Mappings ------------------------------------------------ {{{

let mapleader = ","
inoremap jk <Esc>
nnoremap ; :
vnoremap ; :
" (normal regex)
nnoremap / /\v
vnoremap / /\v
" fix nav, disable arrows
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap <silent> j gj
nnoremap <silent> k gk

nnoremap <silent> <F5> :source $MYVIMRC<CR>

" moving between splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
 
" Swap between buffers
nnoremap <C-g> :bnext<CR>
nnoremap <C-f> :bprev<CR>

" Space to toggle folds
nnoremap <space> za
vnoremap <space> za

" Man
nnoremap M K

" D deletes to end of line
nnoremap D d$

" Don't move on *
nnoremap * *<c-o>

" Keep search in middle of window
nnoremap n nzzzv
nnoremap N Nzzzv

" Move to end/beginning of line
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L g_

" Move line up/down
nnoremap - ddp
nnoremap _ dd2kp

" Split line, cc for normal S
nnoremap S i<CR><ESC>^mwgk:silent! s/\v +$//<CR>:noh<CR>`w
nnoremap <C-n> :NERDTreeToggle<CR>

nnoremap gn :cnext<cr>
nnoremap gp :cprev<cr>

" sudo hack
cmap w!! silent w !sudo tee %

" }}}

" Leader mappings ----------------------------------------- {{{

" turn off search highlights
nnoremap <leader><space> :noh<CR>
" re-hardwrap para
nnoremap <leader>q gqip
" reselect text that was just pasted
nnoremap <leader>v V`]
" edit .vimrc in a vertical split!
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<CR>
" new vertical split, switch
nnoremap <leader>w <C-w>v<C-w>l
" Lazy substitute
nnoremap <leader>s :%s/
vnoremap <leader>s :%s/

" Toggle invis chars
nnoremap <leader>i :set list!<CR>

" Copy and comment line
nnoremap <leader>cz yy:call NERDComment(0, "toggle")<CR>p
vnoremap <leader>cz y:call NERDComment('x', "toggle")<CR>`>p

nnoremap <leader>b :Make<CR>
nnoremap <F5> :so $MYVIMRC<CR>

nnoremap <leader>f :NERDTreeFind<CR>

"nnoremap <leader>gi :w<CR>:GoImports<CR>

nnoremap <leader>r :Rg<space>
nnoremap <leader>R :Rg<space>'\b<C-r><C-w>\b'<CR>

" }}}

" Local leader mappings -------------------------------------------- {{{

" }}}

" vimtags ------------------------------------------------- {{{
let Tlist_Ctags_Cmd = "/usr/bin/ctags"
let Tlist_WinWidth = 50
map <F4> :TlistToggle<CR>
" }}}

" Auto-command groups ------------------------------------- {{{
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd vimenter * if !argc() | NERDTree | endif

" Vimscript file settings --------------------------------- {{{
augroup filetype_vim
    au!
    au FileType vim setlocal foldmethod=marker
    au FileType vim setlocal foldlevelstart=0
augroup END
" }}}

augroup filetype_yaml
    au!
    au FileType yaml setlocal tabstop=2
    au FileType yaml setlocal softtabstop=2
    au FileType yaml setlocal shiftwidth=2
augroup END

" quickfix
autocmd! FileType qf nnoremap <buffer> <C-v> <C-w><Enter><C-w>L

" }}}

let g:go_fmt_autosave = 0
"let g:go_fmt_command = "goimports"
let g:go_def_mode = "gopls"
let g:go_info_mode="gopls"

nmap <silent> gp <Plug>(coc-diagnostic-prev)
nmap <silent> gn <Plug>(coc-diagnostic-next)

augroup goImport
  autocmd!
  autocmd BufWritePre *.go call CocAction('runCommand', 'editor.action.organizeImport')
augroup END

set mouse=a
set ttymouse=sgr

hi Comment ctermfg=244

"let &t_ut=''

augroup resCur
  autocmd!
  autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c

set signcolumn=yes

abbreviate todo: TODO(ktravis):
abbreviate TODO: TODO(ktravis):

nmap <leader>rn <Plug>(coc-rename)

inoremap <silent><expr> <c-n> coc#refresh()

