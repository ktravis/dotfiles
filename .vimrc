" Plugins {{{

call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'pbogut/fzf-mru.vim'
Plug 'airblade/vim-gitgutter'
Plug 'fatih/vim-go'
Plug 'honza/vim-snippets'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-commentary'
Plug 'sjl/badwolf'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'nikolvs/vim-sunbather'
" Plug 'ajmwagar/vim-deus'
Plug 'joshdick/onedark.vim'

call plug#end()

" }}}

" Settings {{{

syntax on

set nu
set nocompatible
set wrap                " for long lines
set textwidth=120       " #
set formatoptions=qn1   " #
set formatoptions-=tca
set scrolloff=3
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
set nocompatible

set backup
set backupdir=$HOME/.vim/backup//

set undofile
set undodir=$HOME/.vim/undo//
set undolevels=1000  "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

set magic
set ignorecase
set smartcase
set gdefault " :%s/foo/bar/ instead of :%s/foo/bar/g
set incsearch " highlight search stuff
set showmatch " #
set hlsearch  " #
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮

set wildmenu
set wildmode=list:longest
set updatetime=300
set signcolumn=yes

let g:netrw_liststyle = 3
"let g:netrw_banner = 0

let g:go_fmt_command = "goimports"

set mouse=a
set ttymouse=sgr
set tags^=$HOME/.vim/ctags/c

let g:gutentags_cache_dir='~/.vim/ctags/'

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" set the cursor to bar in insert
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

set t_Co=256
set termguicolors

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

set background=dark    " Setting dark mode
colorscheme onedark

set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L
set guifont=Inconsolata\ Bold\ 12

hi link CocErrorFloat Normal
hi Search ctermbg=228
hi clear SignColumn
hi Comment ctermfg=7 cterm=bold

set grepprg=rg\ --vimgrep
set grepformat=%f:%l:%c:%m

" FZF Rg preview
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* Goob
\ call fzf#run({
\   'source':
\     map(split(globpath(&rtp, "colors/*.vim"), "\n"),
\         "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')"),
\   'sink':    'edit',
\   'options': '+m',
\   'left':    30
\ })<CR>

" FZF don't skip hidden dirs
let $FZF_DEFAULT_COMMAND = 'rg --hidden -l ""'

" }}}

" Mappings {{{

" sudo hack
cmap w!! silent w !sudo tee %

let mapleader = ","
inoremap jk <Esc>
nnoremap ; :
nnoremap <silent> j gj
nnoremap <silent> k gk

" Move to end/beginning of line
nnoremap H ^
vnoremap H ^
nnoremap L $
vnoremap L g_

" moving between splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Space to toggle folds
nnoremap <space> za

nnoremap D d$
nnoremap S i<CR><ESC>^mwgk:silent! s/\v +$//<CR>:noh<CR>`w

nnoremap <silent> <F5> :source $MYVIMRC<CR>

nnoremap <C-p> :FZFMru<CR>

" }}}

" coc.nvim {{{

nmap <silent> gp <Plug>(coc-diagnostic-prev)
nmap <silent> gn <Plug>(coc-diagnostic-next)

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" }}}

" Leader mappings {{{

" reselect text that was just pasted
nnoremap <leader>v V`]

" Copy and comment line
nnoremap <leader>cz yy:call NERDComment(0, "toggle")<CR>p
vnoremap <leader>cz y:call NERDComment('x', "toggle")<CR>`>p

nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<CR>
nnoremap <leader>r :Rg<space>
nnoremap <leader>R :Rg<space><C-r><C-w><CR>


nnoremap <leader>f :GFiles<CR>
nnoremap <leader>F :FZF<CR>


" }}}

" Local leader mappings {{{

" }}}

" Auto-command groups {{{

"autocmd QuickFixCmdPost [^l]* nested cwindow

autocmd FileType c   let b:vcm_tab_complete = "omni"
autocmd FileType cpp let b:vcm_tab_complete = "omni"

"autocmd BufWritePre *.go call CocAction('runCommand', 'editor.action.organizeImport')

augroup filetype_yaml
    au!
    au FileType yaml setlocal shiftwidth=2
    au FileType yaml setlocal softtabstop=2
augroup END

augroup filetype_javascript
    au!
    au FileType javascript setlocal shiftwidth=2
    au FileType javascript setlocal softtabstop=2
augroup END

augroup filetype_javascriptreact
    au!
    au FileType javascriptreact setlocal shiftwidth=2
    au FileType javascriptreact setlocal softtabstop=2
augroup END

augroup init_quickfix
  autocmd!
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost l* lwindow
augroup END

" Vimscript file settings {{{

augroup filetype_vim
    au!
    au FileType vim setlocal foldmethod=marker
    au FileType vim setlocal foldlevelstart=0
augroup END

" }}}

" }}}

" Abbreviations {{{
abbreviate todo: TODO(ktravis):
abbreviate TODO: TODO(ktravis):
abbreviate note: NOTE(ktravis):
abbreviate NOTE: NOTE(ktravis):
abbreviate xxx: XXX(ktravis):
abbreviate XXX: XXX(ktravis):
" }}}

command! -nargs=+ Grep execute 'silent grep! <args> | redr!'
