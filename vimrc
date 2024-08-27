"==================================================================="
"
" Map leader key
let mapleader = ' '

" Maps space to colon, time saver
nnoremap ; :

" Set paste mode toggle key
set pastetoggle=<insert>

" Short key for vim config
nnoremap <leader>r :source ~/.vimrc<CR>
noremap <Leader>ev :tabnew $MYVIMRC<CR>
nnoremap q <esc>
nnoremap Q q


" Short key to change display
nnoremap <Leader>l :set list!<CR>

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

" Key Remapping
imap jk <Esc>
nnoremap tn  :tabnew<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tc  :tabclose<CR>

vnoremap y ygv<Esc> " keep cursor position after visual yank
"vnoremap <Leader>tc c<C-r>=system('~/.config/tcc', getreg('"'))[:-2]<CR>

" Move  select lines up or down
nnoremap <C-k> :m .-2<CR>==
nnoremap <C-j> :m .+1<CR>==
vnoremap <C-k> :m '<-2<CR>gv=gv
vnoremap <C-j> :m '>+1<CR>gv=gv
nnoremap <C-Up> :m .-2<CR>==
nnoremap <C-Down> :m .+1<CR>==
vnoremap <C-Up> :m '<-2<CR>gv=gv
vnoremap <C-Down> :m '>+1<CR>gv=gv

"Keep search pattern at the center of the screen."
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
nnoremap <silent> <c-o> <c-o>zz
nnoremap <silent> <c-i> <c-i>zz

" Seamlessly treat visual lines as actual lines when moving around.
noremap j gj
noremap k gk
noremap <Down> gj
noremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" Navigate around splits with a single key combo.
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-j> <C-w><C-j>

" Cycle through splits.
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

" Copy the current buffer's absolute path to your clipboard.
nnoremap cp :call OSCYank(expand("%:p"))<CR>

" The same as above but instead of acting on the whole file it will be
" restricted to the previously visually selected range. You can do that by
" pressing *, visually selecting the range you want it to apply to and then
" press a key below to replace all instances of it in the current selection.
xnoremap <Leader>r :s///g<Left><Left>
xnoremap <Leader>rc :s///gc<Left><Left><Left>

" Type a replacement term and press . to repeat the replacement again. Useful
" for replacing a few instances of the term (comparable to multiple cursors).
nnoremap <silent> <Leader>8 :let @/='\<'.expand('<cword>').'\>'<CR>cgn
xnoremap <silent> <Leader>8 "sy:let @/=@s<CR>cgn

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

nnoremap <silent> <Leader>c :call QuickFix_toggle()<CR>

" Navigate the complete menu items like CTRL+n / CTRL+p would.
inoremap <expr> <Down> pumvisible() ? "<C-n>" :"<Down>"
inoremap <expr> <Up> pumvisible() ? "<C-p>" : "<Up>"

" Select the complete menu item like CTRL+y would.
inoremap <expr> <Right> pumvisible() ? "<C-y>" : "<Right>"
inoremap <expr> <CR> pumvisible() ? "<C-y>" :"<CR>"

" Cancel the complete menu item like CTRL+e would.
inoremap <expr> <Left> pumvisible() ? "<C-e>" : "<Left>"


" **************Custom key map*******************
nnoremap <silent> <leader>w :w<Cr>
nnoremap <leader>q :q<Cr>
nnoremap <leader>e :e!<Cr>
" 显示当前文件启用的高亮组设置
nnoremap <silent> <leader>h :so $VIMRUNTIME/syntax/hitest.vim<CR>
" 去除搜索高亮和插入高亮
nnoremap <silent> <leader>n :let @/=''<CR>:2match none<CR>



nnoremap ee  $%i<space><space>return;<CR><Esc>
nnoremap ss  :w<CR>:bn<CR>




"======================Set Vim Default Attributes==================="
" 去掉有关vi一致性模式,避免操作习惯上的局限.
set nocompatible

set updatetime=1000

" change buffer without save
set hidden

set splitbelow
set splitright
set ttyfast

set undodir=/tmp
set undofile
set virtualedit=block

" force vim pair match by %, like if/else
runtime! macros/matchit.vim

set foldcolumn=1
set signcolumn=yes

" 设置文件编码,主要是避免中文乱码.
" 先注释,后续遇到中文乱码再打开
"set fileencodings=utf-8,cp936,big5,latin1

" Paste mode donot change content from clipboard

" history : how many lines of history VIM has to remember
set history=2000

" Color
set t_Co=256

" Syntax setting
syntax on
"syntax enable

" set swap file directory
set directory=~/.tmp,.

" Clipboard
set clipboard=unnamed

" Disable mouse in vim
set mouse=""


" 检测文件类型,并载入文件类型插件,
" 为特定文件类型载入相关缩进文件
filetype plugin indent on

" For regular expressions turn magic on
set magic

" Change the terminal's title
set title

" Close vim warning bell and screen flash
set novisualbell                " turn off visual bell
set noerrorbells                " don't beep
set visualbell t_vb=            " turn off error beep/flash
set t_vb=
set tm=300

" 默认按下Esc后,需要等待1秒才生效,
" 设置Esc超时时间为100ms,尽快生效
set ttimeout
set ttimeoutlen=100

" modeline
set modeline

" Set backspace key work normally
set backspace=indent,eol,start

"========================== Basic autocommands======================"

" Auto-resize splits when Vim gets resized.
autocmd VimResized * wincmd =

" Update a buffer's contents on focus if it changed outside of Vim.
"au FocusGained,WinEnter * :checktime

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
au BufReadPost * if line("'\"") > 0 | if line("'\"") <= line("$") | exe("norm '\"") | else |exe "norm $"| endif | endif

" Make sure all types of requirements.txt files get syntax highlighting.
autocmd BufNewFile,BufRead requirements*.txt set ft=python

" Ensure all Markdown files don't get whitespace stripped but let it be visible.
autocmd FileType markdown DisableStripWhitespaceOnSave

" Ensure tabs don't get converted to spaces in Makefiles.
autocmd FileType make setlocal noexpandtab

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

command! Todo call s:todo()

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

command! -bang Profile call s:profile(<bang>0)

"========================Set Vim Display============================"

"Some vim ui settings
"
set number
"set relativenumber     " show relative number
set nowrap              "display too long line on one line
set linebreak           "this help wrap option display better
set showcmd             "show vim input cmd keys
set showmode            "show vim mode
set showmatch           "show the corresponding parentheses
set ruler

" 使用Tab键补全时,在状态栏显示匹配的列表,
" 方便查看都有哪些命令符合补全条件.
set wildmenu

" cursorlineopt=number只高亮行号部分,不影响正文内容
" 的显示. 在其他容易看到光标的终端上可以去掉这两个设置.
"set cursorlineopt=number
set cursorline
set cursorcolumn
"

" Keep some lines with screen top and bottom when scrolling
set scrolloff=7

" 针对特定类型的代码文件,设置显示Tab键和行尾空格以便在
" 开关list来动态切换显示.
autocmd FileType c,cpp,java,xml setlocal list | set listchars=tab:>~,trail:.

" 1=启动显示状态行, 2=总是显示状态行.
set laststatus=2

" 设置状态行显示的内容. %F: 显示当前文件的完整路径.
" %r: 如果readonly,会显示[RO]
" %B: 显示光标下字符的编码值,十六进制.
" %l:光标所在的行号. %v:光标所在的虚拟列号.
" %P: 显示当前内容在整个文件中的百分比.
" %H和%M是strftime()函数的参数,获取时间.
set statusline+=%F%r%y%m\ [HEX=%B][%l,%v,%P]\ %{strftime(\"%H:%M\")}


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

"==================Vim Indent and Search Setting===================="
" Set tab display 4 spaces
set tabstop=4

" Auto convert tab to spaces
set expandtab

" Set auto indent 4 spaces when using </>
set shiftwidth=4

" Open auto indent
set autoindent

" 设置softtabstop有一个好处是可以用Backspace键来一次
" 删除4个空格. softtabstop的值为负数,会使用shiftwidth
" 的值,两者保持一致,方便统一缩进.
set softtabstop=-1

" Automatically ignore case when searching
set ignorecase

" 高亮显示所有搜索到的内容.后面用map映射
" 快捷键来方便关闭当前搜索的高亮.
set hlsearch

" 光标立刻跳转到搜索到内容
set incsearch

" 搜索到最后匹配的位置后,再次搜索不回到第一个匹配处
set wrapscan



"=====================Vim Display Color Setting====================="
"
" 设置颜色主题,适用于黑色背景.
"colorscheme slate

" ColorScheme  example
"hi CursorLine   cterm=NONE ctermbg=grey ctermfg=green guibg=NONE guifg=NONE
"
" Custome Highlight Group
hi MyTabSpace cterm=none ctermfg=none ctermbg=none
hi MyInsertContent cterm=none ctermfg=green ctermbg=darkgrey
hi MyEchoMes cterm=none ctermfg=red ctermbg=none

" set vim messege highlight
echohl MyEchoMes

" 将tab字符和空格的颜色组为MyTabSpace,
"match MyTabSpace /\t\| /
call matchadd('MyTabSpace', ' ', 1000)


hi CursorColumn   cterm=none ctermbg=238 ctermfg=none
hi CursorLine   cterm=none ctermbg=238 ctermfg=none
hi Visual   cterm=none ctermbg=green ctermfg=red
hi Search       cterm=none ctermbg=yellow ctermfg=red
"hi IncSearch       cterm=none ctermbg=yellow ctermfg=red
highlight Folded ctermfg=red ctermbg=none
highlight FoldColumn ctermfg=yellow ctermbg=NONE
highlight SignColumn ctermbg=none ctermfg=LightGrey

"********* auto highlight the last insert context ******
autocmd InsertEnter *   let b:CursorLineBeforeIns = line(".") |
            \  let b:CursorColBeforeIns = col(".")

autocmd InsertLeave *   let b:CursorLineAfterIns = line(".")  |
            \  let b:CursorColAfterIns = col(".")

"autocmd InsertLeave * echom  b:CursorLineBeforeIns b:CursorColBeforeIns b:CursorLineAfterIns b:CursorColAfterIns
autocmd InsertLeave * echom "INSERT: '" . @. . "'" |
            \ execute '2match MyInsertContent ' . '/\%' . b:CursorLineBeforeIns . 'l\%' . b:CursorColBeforeIns .
            \ 'c\(.\|\n\)*\%' . b:CursorLineAfterIns . 'l\%' . b:CursorColAfterIns .'c./'





autocmd BufEnter * silent!  2match none |
            \ silent! execute '2match MyInsertContent ' . '/\%' . b:CursorLineBeforeIns . 'l\%' . b:CursorColBeforeIns .
            \ 'c\(.\|\n\)*\%' . b:CursorLineAfterIns . 'l\%' . b:CursorColAfterIns .'c./'

"===========================Vim Plugins============================="

" check plug.vim ,if no plug.vim ,install it
if !filereadable(expand("~/.vim/autoload/plug.vim"))
    " 如果不存在，使用 curl 下载
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    " 提示用户
    echom "Downloaded vim-plug successfully!"
endif

" Vim plugins Install

call plug#begin()

"List your plugins here
Plug 'zhangzz21/vim-oscyank', {'branch': 'main'} "set vim OSC52 clipboard support

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Better manage Vim sessions.
Plug 'tpope/vim-obsession'

"file zoom
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" Pass focus events from tmux to Vim (useful for autoread and linting tools).
Plug 'tmux-plugins/vim-tmux-focus-events'

" Navigate and manipulate files in a tree view.
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-mapping-mark-children.vim'

" Helpers for moving and manipulating files / directories.
Plug 'tpope/vim-eunuch'

" Run a diff on 2 directories.
Plug 'will133/vim-dirdiff'

" Run a diff on 2 blocks of text.
Plug 'AndrewRadev/linediff.vim'

" Briefly highlight which text was yanked.
Plug 'machakann/vim-highlightedyank'

" Highlight which character to jump to when using horizontal movement keys.
Plug 'unblevable/quick-scope'

" Modify * to also work with visual selections.
" use */# to search select test in visual mode
Plug 'nelstrom/vim-visual-star-search'

" Handle multi-file find and replace.
" use grep/ag/etc to search file in quickfix
Plug 'mhinz/vim-grepper'

" Better display unwanted whitespace.
Plug 'ntpeters/vim-better-whitespace'

" Toggle comments in various ways.
Plug 'tpope/vim-commentary'

" Automatically set 'shiftwidth' + 'expandtab' (indention) based on file type.
Plug 'tpope/vim-sleuth'

" A number of useful motions for the quickfix list, pasting and more.
Plug 'tpope/vim-unimpaired'

" Drastically improve insert mode performance in files with folds.
Plug 'Konfekt/FastFold'

" Show git file changes in the gutter.
Plug 'mhinz/vim-signify'

" A git wrapper.
Plug 'tpope/vim-fugitive'

" A bunch of useful language related snippets (ultisnips is the engine).
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" Automatically show Vim's complete menu while typing.
Plug 'vim-scripts/AutoComplPop'

" Aligning text
Plug 'godlygeek/tabular'

" If you don't have nodejs and yarn
" use pre build, add 'vim-plug' to the filetype list so vim-plug can update
" this plugin
" see: https://github.com/iamcco/markdown-preview.nvim/issues/50
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() },
                \ 'for': ['markdown', 'vim-plug']}


call plug#end()



"=========================PLUGINS CONFIG============================"
"
"vim-oscyank config
nmap <leader>y <Plug>OSCYankOperator
nmap <leader>yy <leader>y_
vmap <leader>y <Plug>OSCYankVisual

"fzf config
let g:fzf_vim = {}
let g:fzf_vim.preview_window = ['right,80%', 'ctrl-/']

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

"goyo config : zoom file like tmux zoom
"goyo will effect colorscheme when exit,so source config
autocmd! User GoyoLeave source ~/.vimrc
nnoremap <Leader>g :Goyo<CR>

" Trigger a highlight in the appropriate direction when pressing these keys:
"let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Better whitespace config
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
nnoremap <leader>s :StripWhitespace<cr>

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
