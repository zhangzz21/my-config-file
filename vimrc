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


" Short key to change display
nnoremap <Leader>l :set list!<CR>


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

" **************Custom key map*******************
nnoremap <leader>w :w<Cr>
nnoremap <leader>q :q<Cr>
" 显示当前文件启用的高亮组设置
nnoremap <leader>h :so $VIMRUNTIME/syntax/hitest.vim<CR>
" 去除搜索高亮和插入高亮
nnoremap <leader>n :noh<CR>:2match none<CR>
nnoremap <leader>c cc<Esc>



nnoremap ee  $%i<space><space>return;<CR><Esc>
nnoremap ss  :w<CR>:bn<CR>




"======================Set Vim Default Attributes==================="
" 去掉有关vi一致性模式,避免操作习惯上的局限.
set nocompatible

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
au FocusGained,BufEnter,VimEnter,WinEnter,BufWinEnter * :checktime

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
set statusline+=%F%r\ [HEX=%B][%l,%v,%P]\ %{strftime(\"%H:%M\")}


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
hi MyTabSpace cterm=none ctermfg=darkgrey
hi MyInsertContent cterm=none ctermfg=green ctermbg=darkgrey
hi MyEchoMes cterm=none ctermfg=red ctermbg=none

echohl MyEchoMes

" 将tab字符和空格的颜色组为MyTabSpace,
match MyTabSpace /\t\| /

hi CursorColumn   cterm=none ctermbg=238 ctermfg=none
hi CursorLine   cterm=none ctermbg=238 ctermfg=none
hi Visual   cterm=none ctermbg=green ctermfg=red
hi Search       cterm=none ctermbg=yellow ctermfg=red
"hi IncSearch       cterm=none ctermbg=yellow ctermfg=red

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
"Plug 'ojroques/vim-oscyank', {'branch': 'main'} "set vim OSC52 clipboard support
Plug 'zhangzz21/vim-oscyank', {'branch': 'main'} "set vim OSC52 clipboard support

call plug#end()

"==================================================================="
nmap <leader>y <Plug>OSCYankOperator
nmap <leader>yy <leader>y_
vmap <leader>y <Plug>OSCYankVisual

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
