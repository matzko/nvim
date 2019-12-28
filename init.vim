set nu
set ai
set ignorecase
set hlsearch

" set noexpandtab
" set the width that tabs appear to be
set tabstop=2
set shiftwidth=2
autocmd FileType elm setlocal shiftwidth=4 tabstop=4
set listchars=tab:·\ ,eol:˺
set list
" use spaces for tabs
" set tabstop=4
" set shiftwidth=4
set expandtab
syntax on
set foldmethod=indent
set diffopt+=iwhite
colorscheme zenburn
colors zenburn

let g:airline_theme = 'one'
let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'

call plug#begin('~/.config/nvim/plugged')

Plug 'AndrewRadev/splitjoin.vim'
Plug 'dense-analysis/ale'
Plug 'elmcast/elm-vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'fishbullet/deoplete-ruby'
Plug 'mhinz/vim-grepper'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-surround'
Plug 'janko-m/vim-test'
Plug 'machakann/vim-highlightedyank'
Plug 'neomake/neomake'
Plug 'codeindulgence/vim-tig'
Plug 'gcmt/taboo.vim'

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Initialize plugin system
call plug#end()

let g:airline_theme='zenburn'
:let mapleader=","

map <Leader>t :TestFile<CR>
map <Leader>s :TestNearest<CR>
map <Leader>l :TestLast<CR>
map <Leader>a :TestSuite<CR>
map <Leader>v :TestVisit<CR>

let test#strategy = "neovim"

let g:deoplete#enable_at_startup = 1
" deoplete select on tab
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

let g:neomake_open_list = 0
let g:neomake_list_height = 1
let g:neomake_elixir_enabled_makers = ['mix', 'credo']

let g:grepper           = {}
let g:grepper.highlight = 1
let g:grepper.tools = ['ag', 'git', 'ack', 'ack-grep', 'grep', 'findstr', 'rg', 'pt', 'sift']

function! DockerTransform(cmd) abort
  if a:cmd =~ './bin/rspec'
    let l:command = substitute(a:cmd, "./bin/rspec", "wecounsel rspec", "")
    return l:command
  else
    return a:cmd
  endif
endfunction

let g:test#custom_transformations = {'docker': function('DockerTransform')}
let g:test#transformation = 'docker'

nmap gs  <plug>(GrepperOperator)
xmap gs  <plug>(GrepperOperator)

let NERDTreeHijackNetrw=1

:set inccommand=split
let g:tig_open_command = 'vnew'

let g:elm_format_autosave = 1
let g:elm_make_output_file = "build/elm.js"

" When writing a buffer.
call neomake#configure#automake('w')
" When writing a buffer, and on normal mode changes (after 750ms).
" call neomake#configure#automake('nw', 750)
" When reading a buffer (after 1s), and when writing.
" call neomake#configure#automake('rw', 1000)
