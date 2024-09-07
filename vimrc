"============================================================================"
"       ███╗   ███╗██╗   ██╗██╗   ██╗██╗███╗   ███╗██████╗  ██████╗          "
"       ████╗ ████║╚██╗ ██╔╝██║   ██║██║████╗ ████║██╔══██╗██╔════╝          "
"       ██╔████╔██║ ╚████╔╝ ██║   ██║██║██╔████╔██║██████╔╝██║               "
"       ██║╚██╔╝██║  ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║               "
"       ██║ ╚═╝ ██║   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗          "
"       ╚═╝     ╚═╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝          "
"============================================================================"



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"              Firstly Set Vim Log File From Vim Start To #Debug             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Firstly Set Vim Log File From Vim Start To Debug
let g:MyVimMesFile=$HOME. '/.vim/log/' .
      \substitute(system('date +"%Y%m%d-%H%M%S-%2N"'), '\n', '', 'g')
"echo g:MyVimMesFile
execute 'redir >> ' . g:MyVimMesFile

" nnoremap <leader>m :redir END

"""""""""""""""""""""""""""""""""""""END""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               basic key map                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Map leader key
let mapleader = ' '

" Use ';' to ex
nnoremap ; :

" Some Simple More friendly Key Remapping
nnoremap q <esc>
nnoremap Q q
nnoremap cc c$
imap jk <Esc>
nnoremap tn  :tabnew<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tc  :tabclose<CR>
" Keep search pattern at the center of the screen."
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
nnoremap <silent> <c-o> <c-o>zz
nnoremap <silent> <c-i> <c-i>zz
" Seamlessly treat visual lines as actual lines when moving around.
noremap 0 ^
noremap ^ 0
noremap j gj
noremap k gk
noremap J 5gj
noremap K 5gk
noremap gj J
noremap gk K " 'K' can call shell cmd,this have many funny use by 'keywordprg'
noremap r <c-r>
" noremap <c-r> r
noremap <Down> gj
noremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" Navigate windows
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-j> <C-w><C-j>
nnoremap <S-Tab> <C-w>w

" Format paragraph (selected or not) to 80 character lines.
nnoremap <Leader>g gqap
xnoremap <Leader>g gqa

" Prevent x and the delete key from overriding what's in the clipboard.
noremap x "_x
noremap X "_x
noremap <Del> "_x

" Prevent selecting and pasting from overwriting what you originally copied.
xnoremap p pgvy

" use <ins>  to toggle paste mode
set pastetoggle=<insert>

" make direction key can navigate in popup menu
inoremap <expr> <Down> pumvisible() ? "<C-n>" :"<Down>"
inoremap <expr> <Up> pumvisible() ? "<C-p>" : "<Up>"
inoremap <expr> <Right> pumvisible() ? "<C-y>" : "<Right>"
inoremap <expr> <Left> pumvisible() ? "<C-e>" : "<Left>"
inoremap <expr> <CR> pumvisible() ? "<C-y>" :"<CR>"

"""""""""""""""""""""""""""""""""""""END""""""""""""""""""""""""""""""""""""""



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              key map command                               "

" Short key for vim config
nnoremap <leader>r      :source ~/.vimrc<CR>
nnoremap <Leader>er     :tabnew $MYVIMRC<CR>
nnoremap <Leader>d      :set mouse=a ttymouse=xterm2<cr>
nnoremap <Leader>dd     :set mouse=<cr>
nnoremap <silent>       <leader>w :w<Cr>
nnoremap <leader>q      :q<Cr>
nnoremap <leader>e      :e!<Cr>
nnoremap <leader>n     :let @/='\aSearchClear\a'<Cr>
nnoremap <Leader>l      :set list! \| set colorcolumn=80<cr>
nnoremap <Leader>ll      :set list! \| set colorcolumn=<cr>
nnoremap <leader>v      :set virtualedit=all<Cr>
nnoremap <leader>vv     :set virtualedit=<Cr>
nnoremap <leader>m  :<c-u><c-r><c-r>='let @'. v:register .' = '.
            \string(getreg(v:register))<cr><c-f><left>

" Toggle quickfix window.
function! QuickFix_toggle()
    for i in range(1, winnr('$'))
        let bnum = winbufnr(i)
        if getbufvar(bnum, '&buftype') == 'quickfix'
            cclose
            return
        endif
    endfor

    copen
endfunction

" Add all TODO items to the quickfix list relative to where you opened Vim.
function! s:todo() abort
  let entries = []
  for cmd in ['git grep -niIw -e TODO -e FIXME 2> /dev/null',
            \ 'grep -rniIw -e TODO -e FIXME . 2> /dev/null']
    let lines = split(system(cmd), '\n')
    if v:shell_error != 0 | continue | endif
    for line in lines
      let [fname, lno, text] = matchlist(line, '^\([^:]*\):\([^:]*\):\(.*\)')[1:3]
      call add(entries, { 'filename': fname, 'lnum': lno, 'text': text })
    endfor
    break
  endfor

  if !empty(entries)
    call setqflist(entries)
    copen
  endif
endfunction

" Profile Vim by running this command once to start it and again to stop it.
function! s:profile(bang)
  if a:bang
    profile pause
    noautocmd qall
  else
    profile start /tmp/profile.log
    profile func *
    profile file *
  endif
endfunction

nnoremap <silent> <Leader>c :call QuickFix_toggle()<CR>
command! Todo call s:todo()
command! -bang Profile call s:profile(<bang>0)

" Copy the current buffer's absolute path to your clipboard.
nnoremap cp :call OSCYank(expand("%:p"))<CR>


" command to highlight select line
nnoremap <silent> <leader>h :call matchadd('MyLineHi', '\%'.line('.').'l')<cr>
nnoremap <silent> <leader>hh :call clearmatches()<cr>


" direct operate other win without switching
nnoremap <M-n>    :call win_execute(win_getid(winnr('j')), "normal! 5j")<cr>
nnoremap <leader>zz    :MaximizerToggle<cr>





" keep cursor position after visual yank
" vnoremap y ygv<Esc>

" nnoremap <silent> <leader>h :so $VIMRUNTIME/syntax/hitest.vim<CR>

" Move  select lines up or down
" nnoremap <C-k> :m .-2<CR>==
" nnoremap <C-j> :m .+1<CR>==
" vnoremap <C-k> :m '<-2<CR>gv=gv
" vnoremap <C-j> :m '>+1<CR>gv=gv
" nnoremap <C-Up> :m .-2<CR>==
" nnoremap <C-Down> :m .+1<CR>==
" vnoremap <C-Up> :m '<-2<CR>gv=gv
" vnoremap <C-Down> :m '>+1<CR>gv=gv

" The same as above but instead of acting on the whole file it will be
" restricted to the previously visually selected range. You can do that by
" pressing *, visually selecting the range you want it to apply to and then
" press a key below to replace all instances of it in the current selection.
"
" xnoremap <Leader>r :s///g<Left><Left>
" xnoremap <Leader>rc :s///gc<Left><Left><Left>

" Type a replacement term and press . to repeat the replacement again. Useful
" for replacing a few instances of the term (comparable to multiple cursors).
"
" nnoremap <silent> <Leader>8 :let @/='\<'.expand('<cword>').'\>'<CR>cgn
" xnoremap <silent> <Leader>8 "sy:let @/=@s<CR>cgn


"""""""""""""""""""""""""""""""""""""END""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            basic #option setting                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" map a-zA-Z key code for some terminal emulator
" some <alt-'*'> may not valid because system key map
function! MySetAltKeyCode()
    for l:i in range(0, 25)
        " áâãäåæçèéêëìîíïðñòóôõö
        execute 'set <M-' . nr2char(l:i + 97) . '>=' . nr2char(l:i + 97)
        "  ÁÂÃ ÅÆÇÈÉÊË
        execute 'set <M-' . nr2char(l:i + 65) . '>=' . nr2char(l:i + 65)
    endfor
endfunction

let &t_k1="\eOP"
call MySetAltKeyCode()

set keywordprg=man " this will be overwrite by setlocal for every ft
set viminfo='100,<50,s10,h
set backspace=indent,eol,start
set history=2000
set hidden        "enable change buffer without saving
set splitbelow
set splitright
set mouse=""
set ttyfast
set nocompatible
set modeline
set t_Co=256
set magic         "default regular expr mode
syntax on
filetype plugin indent on
" set virtualedit=all
" set encoding=utf-8
" set clipboard=unnamed

set updatetime=1000
set maxmempattern=1000000000
set novisualbell                " turn off visual bell
set noerrorbells                " don't beep
set visualbell t_vb=            " turn off error beep/flash
set t_vb=
set tm=300

set ttimeout        "enable escape key code/map overtime
set ttimeoutlen=100

set undofile
set undodir=~/.vim/undodir
set directory=~/.vim/tmp " set swap file directory
command  RMundofile :execute  '!rm  ' . fnameescape(undofile(@%))


let &t_SH = "\e[3 q"
let &t_SI = "\e[0 q"
let &t_EI = "\e[0 q"


" force vim pair match by %, like if/else
runtime! macros/matchit.vim


""""""""""""
"  Vim Ui  "
""""""""""""

" 1=启动显示状态行, 2=总是显示状态行.
set laststatus=2
set foldcolumn=1
set signcolumn=yes
set number
" set relativenumber     " show relative number
set nowrap              "display too long line on one line
set linebreak           "this help wrap option display better
set showcmd             "show vim input cmd keys
set showmode            "show vim mode
set showmatch           "show the corresponding parentheses
set wildmenu            "enable command-line completion
set ruler
set scrolloff=5

" cursorlineopt=number只高亮行号部分,不影响正文内容
" 的显示. 在其他容易看到光标的终端上可以去掉这两个设置.
"set cursorlineopt=number
set cursorline
set cursorcolumn
"

" tab setting
set tabstop=4
set expandtab
set shiftwidth=4
set autoindent
set softtabstop=-1
set smarttab

" searching setting
set ignorecase
set hlsearch
set incsearch
set wrapscan


"""""""""""""""""""""""""""""""""""""END""""""""""""""""""""""""""""""""""""""



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  #autocmd                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd FileType c,cpp,java,xml setlocal list | set listchars=tab:>~,trail:.
" Auto-resize splits when Vim gets resized.
autocmd VimResized * wincmd =

" Only show the cursor line in the active buffer.
augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline |
                \ setlocal cursorcolumn
    au WinLeave * setlocal nocursorline | setlocal nocursorcolumn
augroup END

" Unset paste on InsertLeave.
autocmd InsertLeave * silent! set nopaste

" Make sure all types of requirements.txt files get syntax highlighting.
autocmd BufNewFile,BufRead requirements*.txt set ft=python

" Make sure .aliases, .bash_aliases and similar files get syntax highlighting.
autocmd BufNewFile,BufRead .*aliases* set ft=sh

" Auto move cursor to last exit position
au BufReadPost * if line("'\"") > 0 | if line("'\"") <= line("$") |
            \exe("norm '\"") | else |exe "norm $"| endif | endif

" Make sure all types of requirements.txt files get syntax highlighting.
autocmd BufNewFile,BufRead requirements*.txt set ft=python

" Ensure all Markdown files don't get whitespace stripped but let it be visible.
autocmd FileType markdown DisableStripWhitespaceOnSave

" Ensure tabs don't get converted to spaces in Makefiles.
autocmd FileType make setlocal noexpandtab





""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           custome #color settings                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" set truecolor if term support RGB color set,this will cover all cterm set
if (has("termguicolors"))
  " https://github.com/vim/vim/issues/993#issuecomment-255651605
  "
  " let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  " let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

  " set termguicolors
endif


"
" 设置颜色主题,适用于黑色背景.
" colorscheme slate

" ColorScheme  example
"hi CursorLine   cterm=NONE ctermbg=grey ctermfg=green guibg=NONE guifg=NONE

" Custome Highlight Group
hi MyTabSpace cterm=none ctermfg=none ctermbg=none
hi MyInsertContent cterm=none ctermfg=green ctermbg=darkgrey
hi MyEchoMes cterm=none ctermfg=red ctermbg=none
hi MyLineHi cterm=none ctermfg=darkgrey ctermbg=red

" Vim Highlight Group
highlight ColorColumn ctermbg=238
hi CursorColumn   cterm=none ctermbg=238 ctermfg=none
hi CursorLine   cterm=nocombine ctermbg=238 ctermfg=none
hi Visual   cterm=none ctermbg=green ctermfg=red
hi Search       cterm=none ctermbg=yellow ctermfg=red
"hi IncSearch       cterm=none ctermbg=yellow ctermfg=red
highlight Folded ctermfg=red ctermbg=none
highlight FoldColumn ctermfg=yellow ctermbg=NONE
highlight SignColumn ctermbg=none ctermfg=LightGrey

" set vim messege highlight
echohl MyEchoMes

" 将tab字符和空格的颜色组为MyTabSpace,
" match MyTabSpace /\t\| /
" call matchadd('MyTabSpace', ' ', 1000)






""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  VIM PLUG                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" check plug.vim ,if no plug.vim ,install plug.vim
if !filereadable(expand("~/.vim/autoload/plug.vim"))
    " 如果不存在，使用 curl 下载
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    " 提示用户
    echom "Downloaded vim-plug successfully!"
endif




""""""""""""""""""""
"  #PLUGS INSTALL  "
""""""""""""""""""""
call plug#begin()

" VIM 中文文档
Plug 'yianwillis/vimcdoc'

" copy to clipboard by osc52 without gui
Plug 'zhangzz21/vim-oscyank', {'branch': 'main'}

" vim theme
Plug 'dracula/vim', { 'as': 'dracula' }

" vim ui plugs
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'bling/vim-bufferline'
" Plug 'edkolev/tmuxline.vim' " set tmux line as vim line

" change windows display
Plug 'szw/vim-maximizer'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" customize vim initial interface
Plug 'mhinz/vim-startify'

" Modify * to also work with visual selections.
Plug 'nelstrom/vim-visual-star-search'

" Toggle comments in various ways.
Plug 'tpope/vim-commentary'

" auto complete path pair char ,etc []/()
Plug 'Raimondi/delimitMate'

" use ds/cs/ys/vS add pair char like ()/"" around textobj
Plug 'tpope/vim-surround'

" use alt + j/k/h/l to move select block
Plug 'matze/vim-move'

" linux file command exec in vim : rm,mkdir,mv,find,sudo,wall,locate,cp,etc
Plug 'tpope/vim-eunuch'

" execute shell command, show result in quickfix
Plug 'skywind3000/asyncrun.vim'

" Better manage Vim sessions.
Plug 'tpope/vim-obsession'

" Run a diff on 2 directories.
Plug 'will133/vim-dirdiff'

" Run a diff on 2 blocks of text.
Plug 'AndrewRadev/linediff.vim'

" Better display unwanted whitespace.
Plug 'ntpeters/vim-better-whitespace'

" Automatically set tab by filetype
Plug 'tpope/vim-sleuth'

" Highlight which character to jump to when using horizontal movement keys.
Plug 'unblevable/quick-scope'

" use tab to complete word in insert mode
Plug 'ervandew/supertab'

" Automatically show popup menu ,this may be annoy,default close it
Plug 'vim-scripts/AutoComplPop'

" A bunch of useful language related snippets (ultisnips is the engine).
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" Drastically improve insert mode performance in files with folds.
Plug 'Konfekt/FastFold'

" A git wrapper.
Plug 'tpope/vim-fugitive'

" Show git diff changes in the left gutter.
Plug 'mhinz/vim-signify'

" ☆ auto check syntax error based LSP realtimely
Plug 'dense-analysis/ale'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" fuzzy searh writed by vimscript
Plug 'ctrlpvim/ctrlp.vim'

" highlight text when yank
Plug 'machakann/vim-highlightedyank'

" <Leader>(1-6) to Highlight word ,<Leader>0 to clear
Plug 'idbrii/vim-hiinterestingword'

" show 265 xterm colors
Plug 'guns/xterm-color-table.vim'


" add vim textobj
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-syntax'
Plug 'kana/vim-textobj-function', { 'for':['c', 'cpp', 'vim', 'java'] }
Plug 'sgur/vim-textobj-parameter'
Plug 'coderifous/textobj-word-column.vim'

" Aligning text
Plug 'godlygeek/tabular'

" Navigate and manipulate files in a tree view.
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-mapping-mark-children.vim'

" A number of useful motions for the quickfix list, pasting and more.
Plug 'tpope/vim-unimpaired'

"FUNNY VIM Draw ascii art
Plug 'vim-scripts/DrawIt'

" set FocusGained and FocusLost term code t_ti t_te, old vim may need
" Plug 'tmux-plugins/vim-tmux-focus-events'

" visual-block, but the plugin works mostly from normal mode.
" Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" " use grep/ag/etc to search file in quickfix
" Plug 'mhinz/vim-grepper'

" " interactive window choose mode
" Plug 't9md/vim-choosewin'

call plug#end()

""""""""""""""""""""
"  #PLUGS INSTALL  "
""""""""""""""""""""
let g:mkdp_markdown_css = expand("~/github-markdown.css")

"=========================PLUGINS CONFIG============================"
"
"vim-oscyank config
nmap <leader>y <Plug>OSCYankOperator
nmap <leader>yy <leader>y_
vmap <leader>y <Plug>OSCYankVisual

"fzf config
let g:fzf_vim = {}
let g:fzf_vim.preview_window = ['right,50%', 'ctrl-/']
let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

" Customize fzf colors to match your color scheme.
" let g:fzf_colors =
" \ { 'fg':      ['fg', 'Normal'],
"   \ 'bg':      ['bg', 'Normal'],
"   \ 'hl':      ['fg', 'Comment'],
"   \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
"   \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
"   \ 'hl+':     ['fg', 'Statement'],
"   \ 'info':    ['fg', 'PreProc'],
"   \ 'prompt':  ['fg', 'Conditional'],
"   \ 'pointer': ['fg', 'Exception'],
"   \ 'marker':  ['fg', 'Keyword'],
"   \ 'spinner': ['fg', 'Label'],
"   \ 'header':  ['fg', 'Comment'] }

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-b': 'split',
  \ 'ctrl-v': 'vsplit',
  \ 'ctrl-y': {lines -> OSCYank(join(reverse(lines), "\n"))}}

" Launch fzf with CTRL+P.
nnoremap <silent> <C-p> :FZF -m<CR>

" Map a few common things to do with FZF.
nnoremap <silent> <Leader><Enter> :Buffers<CR>

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-j><c-k> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)


""""""""""""""""""
"  ferm  config  "
""""""""""""""""""

" Disable netrw.
let g:loaded_netrw  = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1

augroup my-fern-hijack
  autocmd!
  autocmd BufEnter * ++nested call s:hijack_directory()
augroup END

function! s:hijack_directory() abort
  let path = expand('%:p')
  if !isdirectory(path)
    return
  endif
  bwipeout %
  execute printf('Fern %s', fnameescape(path))
endfunction

" Custom settings and mappings.
"let g:fern#disable_default_mappings = 1
"let g:fern#default_hidden = 1

noremap <silent> <Leader>f :Fern . -drawer -reveal=% -toggle -width=35<CR>


" .............................................................................
" mhinz/vim-grepper
" .............................................................................

let g:grepper={}
let g:grepper.tools=["rg"]

xmap gr <plug>(GrepperOperator)

" " After searching for text, press this mapping to do a project wide find and
" " replace. It's similar to <leader>r except this one applies to all matches
" " across all files instead of just the current file.
" nnoremap <Leader>R
"   \ :let @s='\<'.expand('<cword>').'\>'<CR>
"   \ :Grepper -cword -noprompt<CR>
"   \ :cfdo %s/<C-r>s//g \| update
"   \<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

" " The same as above except it works with a visual selection.
" xmap <Leader>R
"     \ "sy
"     \ gvgr
"     \ :cfdo %s/<C-r>s//g \| update
"      \<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

" .............................................................................
" ntpeters/vim-better-whitespace
" .............................................................................

let g:strip_whitespace_confirm=0
let g:strip_whitelines_at_eof=1
let g:strip_whitespace_on_save=1
" list to control filetype not be strip when saving
let g:better_whitespace_filetypes_blacklist=[]
"nnoremap <leader>s :StripWhitespace<cr>

" .............................................................................
" SirVer/ultisnips
" .............................................................................

let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"



"goyo config : zoom file like tmux zoom
"goyo will effect colorscheme when exit,so source config
autocmd! User GoyoLeave source ~/.vimrc
nnoremap <Leader>g :Goyo 100<CR>
nnoremap <Leader>z :Goyo 100%x100%<CR>

"""""""""""""""""""""""
"  limelight CONFIG   "
"""""""""""""""""""""""
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'


" Default: 0.5
let g:limelight_default_coefficient = 1

" Number of preceding/following paragraphs to include (default: 0)
let g:limelight_paragraph_span = 1

" Beginning/end of paragraph
"   When there's no empty line between the paragraphs
"   and each paragraph starts with indentation
" let g:limelight_bop = '^\s'
" let g:limelight_eop = '\ze\n^\s'

" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1


" Trigger a highlight in the appropriate direction when pressing these keys:
"let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

""""""""""""""""""""
"  AIRLINE CONFIG  "
""""""""""""""""""""
let g:airline_powerline_fonts = 1
" let g:airline_statusline_ontop=1
let g:airline_theme='bubblegum'

let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#left_sep = ' '
" let g:airline#extensions#tabline#left_alt_sep = '|'
" let g:airline_statusline_ontop=1
" let g:airline_highlighting_cache = 1


" Customize airline show text sample
" function! AccentDemo()
"   let keys = ['a','b','c','d','e','f','g','h']
"   for k in keys
"     call airline#parts#define_text(k, k)
"   endfor
"   call airline#parts#define_accent('a', 'red')
"   call airline#parts#define_accent('b', 'green')
"   call airline#parts#define_accent('c', 'blue')
"   call airline#parts#define_accent('d', 'yellow')
"   call airline#parts#define_accent('e', 'orange')
"   call airline#parts#define_accent('f', 'purple')
"   call airline#parts#define_accent('g', 'bold')
"   call airline#parts#define_accent('h', 'italic')
"   let g:airline_section_a = airline#section#create(keys)
" endfunction
"
" Display value of the char under the cursor, in hex
autocmd VimEnter * let g:airline_section_a = g:airline_section_a . '[%B]'
autocmd VimEnter * AirlineRefresh


" Trigger a highlight in the appropriate direction when pressing these keys.
let g:qs_highlight_on_keys=['f', 'F', 't', 'T']

" Only underline the highlights instead of using custom colors.
highlight QuickScopePrimary gui=underline cterm=underline
highlight QuickScopeSecondary gui=underline cterm=underline

" some recommended plugins for c/c++: gtags,cscopetag
"" vim 用 map 命令来映射快捷键,它前面可以加一些前缀来对应
"" 不同的场景.下面 map 前面的 nore 表示非递归. nore 前面
"" 的n表示只在普通模式下生效.即,基于下面的配置,在插入模式下,
"" 按F6没有这个映射效果.插入模式对应i. 下面配置cscope查找
"" 文件命令的快捷键为F6,由于需要手动输入文件名,不要加<CR>
"nnoremap <F6> :cs find f<Space>
"
"" 配置 gtags 插件,用于在函数之间跳转,方便查看源代码.
"" 参考 gtags-cscopde.vim 的注释,添加下面语句来
"" 使用 ':tag' 和 '<C-]>'
"set cscopetag
"" 设置 cscopetag 后,由于gtags-cscopde默认没有启动,
"ojroques" 还需要进行下面的设置.结合这两个设置, gtags 就可以
"" 使用Ctrl-]键来跳转到函数定义处.
"let GtagsCscope_Auto_Load = 1
"" 配置 GtagsCscope_Auto_Load = 1 后,在没有GTAGS文件
"" 的目录下使用vim,会提示 Gtags-cscope: GTAGS not found.
"" Press ENTER or type command to continue
"" 需要按回车才会打开文件.如果要去掉这个报错,需要设置GtagsCscope_Quiet = 1
"let g:GtagsCscope_Quiet = 1
"" 设置只有一个匹配结果时,不显示quickfix窗口
"let g:Gtags_Close_When_Single = 1
"
" Set cursor style
" Reference chart of values:
"   Ps = 0  -> blinking block.
"   Ps = 1  -> blinking block (default).
"   Ps = 2  -> steady block.
"   Ps = 3  -> blinking underline.
"   Ps = 4  -> steady underline.
"   Ps = 5  -> blinking bar (xterm).
"   Ps = 6  -> steady bar (xterm).
" let &t_SI = "\e[6 q"
" let &t_EI = "\e[2 q"
" 设置状态行显示的内容. %F: 显示当前文件的完整路径.
" %r: 如果readonly,会显示[RO]
" %B: 显示光标下字符的编码值,十六进制.
" %l:光标所在的行号. %v:光标所在的虚拟列号.
" %P: 显示当前内容在整个文件中的百分比.
" %H和%M是strftime()函数的参数,获取时间.
" set statusline+=%F%r%y%m\ [HEX=%B][%l,%v,%P]\ %{strftime(\"%H:%M\")}


"function! s:statusline_expr()
"  let mod = "%{&modified ? '[+] ' : !&modifiable ? '[x] ' : ''}"
"  let ro  = "%{&readonly ? '[RO] ' : ''}"
"  let ft  = "%{len(&filetype) ? '['.&filetype.'] ' : ''}"
"  let fug = "%{exists('g:loaded_fugitive') ? fugitive#statusline() : ''}"
"  let sep = ' %= '
"  let pos = ' %-12(%l : %c%V%) '
"  let pct = ' %P'
"
"  return '[%n] %f %<'.mod.ro.ft.fug.sep.pos.'%*'.pct
"endfunction
"
"let &statusline = s:statusline_expr()
"********* auto highlight the last insert context ******
"autocmd InsertEnter *   let b:CursorLineBeforeIns = line(".") |
"            \  let b:CursorColBeforeIns = col(".")
"
"autocmd InsertLeave *   let b:CursorLineAfterIns = line(".")  |
"            \  let b:CursorColAfterIns = col(".")
"
" autocmd InsertLeave * echom "INSERT: '" . @. . "'" |
"             \ execute '2match MyInsertContent ' . '/\%' . b:CursorLineBeforeIns . 'l\%' . b:CursorColBeforeIns .
"             \ 'c\(.\|\n\)*\%' . b:CursorLineAfterIns . 'l\%' . b:CursorColAfterIns .'c./'




" autocmd BufEnter * silent!  2match none |
"             \ silent! execute '2match MyInsertContent ' . '/\%' . b:CursorLineBeforeIns . 'l\%' . b:CursorColBeforeIns .
"             \ 'c\(.\|\n\)*\%' . b:CursorLineAfterIns . 'l\%' . b:CursorColAfterIns .'c./'
