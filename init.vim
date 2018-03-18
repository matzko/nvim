set nu
set ai
set ignorecase
set hlsearch

" set noexpandtab
" set the width that tabs appear to be
set tabstop=2
set shiftwidth=2
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

call plug#begin('~/.config/nvim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'janko-m/vim-test'
Plug 'machakann/vim-highlightedyank'
Plug 'neomake/neomake'

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

let g:neomake_open_list = 2
let g:neomake_elixir_enabled_makers = ['mix', 'credo']
