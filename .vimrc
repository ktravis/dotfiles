" Plugins
call plug#begin('~/.vim/plugged')

Plug 'junegunn/vim-easy-align'
Plug 'fatih/vim-go'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'chriskempson/base16-vim'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'
Plug 'dylanaraps/wal'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'ajmwagar/vim-dues'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'owickstrom/vim-colors-paramount'
Plug 'jremmen/vim-ripgrep'
Plug 'zxqfl/tabnine-vim'

Plug '~/dotfiles/verse-vim'

call plug#end()

set autowrite
" Settings --------------------------------------------------- {{{
syntax on

let g:lightline = {
    \ 'colorscheme': 'solarized',
    \  }

let NERDTreeIgnore=['\~$', '\.pyc', '\.swp$', '\.git', '\.hg', '\.svn',
      \ '\.ropeproject', '\.o', '\.bzr', '\.ipynb_checkpoints$',
      \ '__pycache__',
      \ '\.egg$', '\.egg-info$', '\.tox$', '\.idea$', '\.sass-cache',
      \ '\.env$', '\.env[0-9]$', '\.coverage$', '\.tmp$', '\.gitkeep$',
      \ '\.coverage$', '\.webassets-cache$', '\.vagrant$', '\.DS_Store',
      \ '\.env-pypy$']

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

set nu
set nocompatible
set wrap                " for long lines
set textwidth=80        " #
set formatoptions=qrn1  " #
" set colorcolumn=+1      " #
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

set noswapfile

set backup
set backupdir=$HOME/.vim/backup//

set undofile
set undodir=$HOME/.vim/undo//
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

" sudo hack
cmap w!! silent w !sudo tee %

" powerline
let g:Powerline_symbols = 'fancy'

"set ignorecase
set smartcase
set gdefault " :%s/foo/bar/ instead of :%s/foo/bar/g
set incsearch " highlight search stuff
set showmatch " #
set hlsearch  " #
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮

" Color settings ------------------------------------------ {{{
set t_Co=256
set bg=dark
"colorscheme base16-materia
"colorscheme base16-eighties
"colorscheme dues
colorscheme paramount
"set bg=light
"colorscheme base16-solarized-light
"colorscheme base16-atelier-plateau-light
"colorscheme base16-gruvbox-dark-medium
"hi Search guifg=white guibg=#839496



set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L
"set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
set guifont=Inconsolata\ Bold\ 12
" }}}

" Wildmenu ------------------------------------------------ {{{
 set wildmenu
 set wildmode=list:longest
 set wildignore+=.hg,.git,.svn                    " Version control
 set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
 set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
 set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
 set wildignore+=*.spl                            " compiled spelling word
 set wildignore+=*.sw?                            " Vim swap files
 set wildignore+=*.DS_Store                       " OSX bullshit
 set wildignore+=*.luac                           " Lua byte code
 set wildignore+=migrations                       " Django migrations
 set wildignore+=*.pyc                            " Python byte code
 set wildignore+=*.orig
" }}}

" }}}

" Mappings ------------------------------------------------ {{{

let mapleader = ","
inoremap jk <Esc>
nnoremap ; :
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

" goddamn help key
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

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
vnoremap L g_

" Move line up/down
nnoremap - ddp
nnoremap _ dd2kp

" Split line, cc for normal S
nnoremap S i<CR><ESC>^mwgk:silent! s/\v +$//<CR>:noh<CR>`w
nnoremap <C-n> :NERDTreeToggle<CR>

nnoremap gn :cnext<cr>
nnoremap gp :cprev<cr>

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

nnoremap <leader>gi :w<CR>:GoImports<CR>

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

" }}}

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

let g:go_fmt_command = "goimports"

set mouse=a

hi Comment ctermfg=244
