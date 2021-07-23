set nu
set relativenumber
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
Plug 'andys8/vim-elm-syntax'
Plug 'neoclide/coc-eslint'
Plug 'neoclide/coc-prettier'
Plug 'neoclide/coc-tsserver'
" Plug 'dense-analysis/ale'
Plug 'elmcast/elm-vim'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'fishbullet/deoplete-ruby'
Plug 'mhinz/vim-grepper'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-surround'
Plug 'vim-test/vim-test'
Plug 'machakann/vim-highlightedyank'
Plug 'neomake/neomake'
Plug 'codeindulgence/vim-tig'
Plug 'gcmt/taboo.vim'

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'neovimhaskell/haskell-vim'
Plug 'sbdchd/neoformat'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }
" nnoremap <silent> <c-x><c-k> :Sayonara!<CR>
nnoremap <silent> <c-k> :Sayonara!<CR>

Plug 'machakann/vim-sandwich'

" Initialize plugin system
call plug#end()

let g:airline_theme='zenburn'
:let mapleader=","

let g:neoformat_enabled_haskell = ['brittany']

map <Leader>t :TestFile<CR>
map <Leader>s :TestNearest<CR>
map <Leader>l :TestLast<CR>
map <Leader>a :TestSuite<CR>
map <Leader>v :TestVisit<CR>

let test#strategy = "neovim"

" open the test results in a buffer
function! BufferTermStrategy(cmd)
  exec 'te ' . a:cmd
endfunction
let g:test#custom_strategies = {'bufferterm': function('BufferTermStrategy')}
let g:test#strategy = 'bufferterm'

nmap <silent> <c-h> :bn<cr>
nmap <silent> <c-l> :bp<cr>


" let g:deoplete#enable_at_startup = 1
" deoplete select on tab
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

let g:neomake_open_list = 0
let g:neomake_list_height = 1
let g:neomake_elixir_enabled_makers = ['mix', 'credo']
let g:neomake_ruby_enabled_makers = []

let g:grepper           = {}
let g:grepper.highlight = 1
let g:grepper.tools = ['ag', 'git', 'ack', 'ack-grep', 'grep', 'findstr', 'rg', 'pt', 'sift']

" function! DockerTransform(cmd) abort
"   if a:cmd =~ './bin/rspec'
"     let l:command = substitute(a:cmd, "./bin/rspec", "wecounsel rspec", "")
"     return l:command
"   else
"     return a:cmd
"   endif
" endfunction

" let g:test#custom_transformations = {'docker': function('DockerTransform')}
" let g:test#transformation = 'docker'

nmap gs  <plug>(GrepperOperator)
xmap gs  <plug>(GrepperOperator)

let NERDTreeHijackNetrw=1

:set inccommand=split
let g:tig_open_command = 'vnew'

let g:elm_format_autosave = 1
let g:elm_make_output_file = "build/elm.js"

" let g:ale_fixers = {
" \   'elm': ['elm-format'],
" \   'javascript': ['prettier'],
" \   'json': ['prettier'],
" \   'css': ['prettier'],
" \   'scss': ['prettier'],
" \   'yaml': ['prettier'],
" \   'markdown': ['prettier'],
" \}
" let g:ale_fix_on_save = 1
" let g:ale_linters = {
" \   'elm': ['make'],
" \   'ruby': ['rubocop', 'reek'],
" \}
" let g:ale_linters_explicit = 1
" let g:ale_lint_on_save = 1
" let g:ale_lint_on_text_changed = 0
" let g:ale_lint_on_insert_leave = 0

" let g:ale_ruby_brakeman_options = "--only-files expand('%:p')"

" When writing a buffer.
" call neomake#configure#automake('w')
" When writing a buffer, and on normal mode changes (after 750ms).
" call neomake#configure#automake('nw', 750)
" When reading a buffer (after 1s), and when writing.
" call neomake#configure#automake('rw', 1000)







" ---- Begin stuff for coc.vim -----
" " TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

iabbrev pp \|>
iabbrev pP <\|

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm(): "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>""
inoremap  <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : " "


" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" ---- end stuff for coc.vim -----



" Keybindings
nmap <leader>r <Plug>(coc-rename)
" nmap <silent> <leader>s <Plug>(coc-fix-current)
nmap <silent> <leader>S <Plug>(coc-codeaction)
" nmap <silent> <leader>a <Plug>(coc-diagnostic-next)
nmap <silent> <leader>A <Plug>(coc-diagnostic-next-error)
nmap <silent> <leader>d <Plug>(coc-definition)
nmap <silent> <leader>g :call CocAction('doHover')<CR>
nmap <silent> <leader>u <Plug>(coc-references)
nmap <silent> <leader>p :call CocActionAsync('format')<CR>


nmap <silent> gr <Plug>(coc-references)
nmap <silent> gd <Plug>(coc-definition)

nnoremap <backspace> <c-^>
nmap <leader>a  <Plug>(coc-codeaction)
