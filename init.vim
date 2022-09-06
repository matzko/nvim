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
let g:python_host_prog = 'python2'
let g:python3_host_prog = 'python3'

:let mapleader=","

call plug#begin('~/.config/nvim/plugged')

Plug 'AndrewRadev/splitjoin.vim'
Plug 'andys8/vim-elm-syntax'
Plug 'mhinz/vim-mix-format'
Plug 'neoclide/coc-eslint'
Plug 'neoclide/coc-prettier'
Plug 'neoclide/coc-tsserver'


" progress plugin:
Plug 'j-hui/fidget.nvim'


Plug 'gelguy/wilder.nvim', { 'do': ':UpdateRemotePlugins' }



" Plug 'dense-analysis/ale'
Plug 'elmcast/elm-vim'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'fishbullet/deoplete-ruby'
Plug 'windwp/nvim-autopairs'
Plug 'mhinz/vim-grepper'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
" Plug 'tpope/vim-surround'
Plug 'vim-test/vim-test'
Plug 'machakann/vim-highlightedyank'
Plug 'neomake/neomake'
Plug 'codeindulgence/vim-tig'
Plug 'gcmt/taboo.vim'

Plug 'airblade/vim-rooter'

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'neovimhaskell/haskell-vim'
Plug 'sbdchd/neoformat'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }
" nnoremap <silent> <c-x><c-k> :Sayonara!<CR>
nnoremap <silent> <c-k> :Sayonara!<CR>

Plug 'machakann/vim-sandwich'


"" FZF {{{
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'chengzeyi/fzf-preview.vim'
Plug 'stsewd/fzf-checkout.vim'

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'Normal'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

let g:fzf_preview_window = ['up:50%', 'ctrl-/']

function! s:getVisualSelection()
  let [line_start, column_start] = getpos("'<")[1:2]
  let [line_end, column_end] = getpos("'>")[1:2]
  let lines = getline(line_start, line_end)

  if len(lines) == 0
    return ""
  endif

  let lines[-1] = lines[-1][:column_end - (&selection == "inclusive" ? 1 : 2)]
  let lines[0] = lines[0][column_start - 1:]

  return join(lines, "\n")
endfunction

function! InsertEmoji(emoji)
    let @a = system('cut -d " " -f 1 | emoji-fzf get', a:emoji)
    normal! "agP
endfunction

command! -bang Emoji
  \ call fzf#run({
      \ 'source': 'emoji-fzf preview',
      \ 'options': '--preview ''emoji-fzf get {1}''',
      \ 'sink': function('InsertEmoji')
      \ })

nnoremap <leader>e :Emoj<CR>
map <C-e> :Emoj<CR>
imap <C-e> <C-o><C-e>

command! -count=10 HFiles call fzf#run({ 'source': 'git log HEAD -n <count> --diff-filter=MA --name-only --pretty=format: | sed -e /^$/d', 'sink': 'edit'})

"" Can do like :Rip -g '*.rb' ''
command! -bang -nargs=* Rip call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".<q-args>, 1, <bang>0)
nnoremap <leader>? :Rip! -g '*.' ''<left><left><left><left>

nnoremap <leader><enter> :FZFMarks!<CR>
nnoremap <leader>/ :FZFRg!<CR>
vnoremap <leader>/ :<C-U>FZFRg! <C-R>=<SID>getVisualSelection()<CR><CR>

nnoremap <silent> <leader>bl :Lines!<CR>
nnoremap <silent> <leader>hh :Helptags!<CR>
" nnoremap <silent> <leader>fr :FZFHistory!<CR>
nnoremap <silent> <leader>fr :CocList mru<CR>
nnoremap <silent> <leader><leader> :Files!<CR>
"" }}}

Plug 'kevinhwang91/nvim-bqf'
" Initialize plugin system
call plug#end()

call wilder#setup({'modes': [':', '/', '?']})
call wilder#set_option('renderer', wilder#popupmenu_renderer({
      \ 'highlighter': wilder#basic_highlighter(),
      \ }))

let g:airline_theme='zenburn'

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

let g:mix_format_on_save = 1

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

nmap <leader>w  <Plug>(coc-float-jump)

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


nmap <silent> <leader>n             :call CocAction('diagnosticNext')<CR>
nmap <silent> <leader>p             :call CocAction('diagnosticPrevious')<CR>

nmap <silent> gr <Plug>(coc-references)
nmap <silent> gd <Plug>(coc-definition)

nnoremap <backspace> <c-^>
nmap <leader>a  <Plug>(coc-codeaction)

" Stuff to keep buffer from closing when ending test
"" Terminals {{{
au TermOpen * setlocal listchars= nonumber norelativenumber
au TermOpen * startinsert
au BufLeave term://* stopinsert
au BufEnter,BufWinEnter,WinEnter term://* if !has_key(b:, '_termdone') | startinsert | endif
au TermClose * ++nested stopinsert | let b:_termdone = 1 | au TermEnter <buffer> stopinsert

tnoremap <Esc> <C-\><C-n>
tnoremap <c-q>> <Esc>
tnoremap <silent> <c-h> <C-\><C-n>:bp<CR>
tnoremap <silent> <c-l> <C-\><C-n>:bn<CR>
"" }}}


function! ToggleQuickFix()
    if getqflist({'winid' : 0}).winid
        cclose
    else
        copen
    endif
endfunction

command! -nargs=0 -bar ToggleQuickFix call ToggleQuickFix()

nnoremap yoq :ToggleQuickFix<CR>


lua require('nvim-autopairs').setup{}


"here is a more exotic version of my original Kwbd script
"delete the buffer; keep windows; create a scratch buffer if no buffers left
function s:Kwbd(kwbdStage)
  if(a:kwbdStage == 1)
    if(&modified)
      let answer = confirm("This buffer has been modified.  Are you sure you want to delete it?", "&Yes\n&No", 2)
      if(answer != 1)
        return
      endif
    endif
    if(!buflisted(winbufnr(0)))
      bd!
      return
    endif
    let s:kwbdBufNum = bufnr("%")
    let s:kwbdWinNum = winnr()
    windo call s:Kwbd(2)
    execute s:kwbdWinNum . 'wincmd w'
    let s:buflistedLeft = 0
    let s:bufFinalJump = 0
    let l:nBufs = bufnr("$")
    let l:i = 1
    while(l:i <= l:nBufs)
      if(l:i != s:kwbdBufNum)
        if(buflisted(l:i))
          let s:buflistedLeft = s:buflistedLeft + 1
        else
          if(bufexists(l:i) && !strlen(bufname(l:i)) && !s:bufFinalJump)
            let s:bufFinalJump = l:i
          endif
        endif
      endif
      let l:i = l:i + 1
    endwhile
    if(!s:buflistedLeft)
      if(s:bufFinalJump)
        windo if(buflisted(winbufnr(0))) | execute "b! " . s:bufFinalJump | endif
      else
        enew
        let l:newBuf = bufnr("%")
        windo if(buflisted(winbufnr(0))) | execute "b! " . l:newBuf | endif
      endif
      execute s:kwbdWinNum . 'wincmd w'
    endif
    if(buflisted(s:kwbdBufNum) || s:kwbdBufNum == bufnr("%"))
      execute "bd! " . s:kwbdBufNum
    endif
    if(!s:buflistedLeft)
      set buflisted
      set bufhidden=delete
      set buftype=
      setlocal noswapfile
    endif
  else
    if(bufnr("%") == s:kwbdBufNum)
      let prevbufvar = bufnr("#")
      if(prevbufvar > 0 && buflisted(prevbufvar) && prevbufvar != s:kwbdBufNum)
        b #
      else
        bn
      endif
    endif
  endif
endfunction

command! Kwbd call s:Kwbd(1)
nnoremap <silent> <Plug>Kwbd :<C-u>Kwbd<CR>
nnoremap <silent> <Leader>bd :Kwbd<CR>

" Create a mapping (e.g. in your .vimrc) like this:
"nmap <C-W>! <Plug>Kwbd
