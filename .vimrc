"
"  Description: VIM configuration
"  Author: LYB 
"  Date: 2014-12-11
"
"
	set nocompatible

	if has("syntax")
	  syntax on            
	endif

	colorscheme torte     " 配色方案 

	filetype on
	filetype plugin on

	set autowrite      
	"set autoindent        " 设置自动对齐(缩进)
	"set smartindent       " 智能对齐方式
	set tabstop=4          " 设置制表符(tab键)的宽度
	set softtabstop=4      " 设置软制表符的宽度    
	set shiftwidth=4       " (自动) 缩进使用的4个空格
	set cindent            " 使用 C/C++ 语言的自动缩进方式
	set cinoptions={0,1s,t0,n-2,p2s,(03s,=.5s,>1s,=1s,:1s     "设置C/C++语言的具体缩进方式
	"set backspace=2       " 设置退格键可用
	set showmatch          " 设置匹配模式，显示匹配的括号
	set linebreak          " 整词换行
	set whichwrap=b,s,<,>,[,] " 光标从行首和行末时可以跳到另一行去
	set number             "显示行号
	"set previewwindow     " 标识预览窗口
	set history=50         "历史记录50条


	"--状态行设置--
	set ruler            " 标尺，用于显示光标位置的行号和列号，逗号分隔。

	"--命令行设置--
	set showcmd           " 命令行显示输入的命令
	set showmode          " 命令行显示vim当前模式

	"--find setting--
	set incsearch        " 输入字符串就显示匹配点
	set hlsearch   

	"--ctags 设置--
	" 按下F5重新生成tag文件，并更新taglist
	map <F5> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> :TlistUpdate<CR>
	imap <F5> <ESC>:!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> :TlistUpdate<CR>
	set tags=tags
	set tags+=./tags "add current directory's generated tags file
	set tags+=/usr/include/c++/tags
	set tags+=/home/liuyingbo/workspace/linux-2.6.32.64/tags 

	"-- omnicppcomplete 设置 --
	imap <F3> <C-X><C-O>
	imap <F2> <C-X><C-I>                " 按下F2根据头文件内关键字补全
	set completeopt=menu,menuone        " 关掉智能补全时的预览窗口
	let OmniCpp_MayCompleteDot = 1      " autocomplete with .
	let OmniCpp_MayCompleteArrow = 1    " autocomplete with ->
	let OmniCpp_MayCompleteScope = 1    " autocomplete with ::
	let OmniCpp_SelectFirstItem = 2     " select first item (but don't insert)
	let OmniCpp_NamespaceSearch = 2     " search namespaces in this and included files
	let OmniCpp_ShowPrototypeInAbbr = 1 " show function prototype in popup window
	let OmniCpp_GlobalScopeSearch=1     " enable the global scope search
	let OmniCpp_DisplayMode=1           " Class scope completion mode: always show all members
	let OmniCpp_DefaultNamespaces=["std"]
	let OmniCpp_ShowScopeInAbbr=1       " show scope in abbreviation and remove the last column
	let OmniCpp_ShowAccess=1

	"-- Taglist 设置--
	let Tlist_Ctags_Cmd='ctags'       "因为我们放在环境变量里，所以可以直接执行
	let Tlist_Use_Right_Window=1      "让窗口显示在右边，0的话就是显示在左边
	let Tlist_Show_One_File=0         "让taglist可以同时展示多个文件的函数列表
	let Tlist_File_Fold_Auto_Close=1  "非当前文件，函数列表折叠隐藏
	let Tlist_Exit_OnlyWindow=1       "当taglist是最后一个分割窗口时，自动推出vim
	let Tlist_Process_File_Always=1   "实时更新tags
	let Tlist_Inc_Winwidth=0

	"-- WinManager 设置 --
	let g:winManagerWindowLayout='FileExplorer|TagList' " 设置我们要管理的插件
	"let g:persistentBehaviour=0                        " 如果所有编辑文件都关闭了，退出vim
	nmap wm :WMToggle<cr> 

	"-- MiniBufferExplorer 设置 --
	let g:miniBufExplMapWindowNavVim = 1    " 按下Ctrl+h/j/k/l，可以切换到当前窗口的上下左右窗口
	let g:miniBufExplMapWindowNavArrows = 1 " 按下Ctrl+箭头，可以切换到当前窗口的上下左右窗口
	let g:miniBufExplMapCTabSwitchBufs = 1  " 启用以下两个功能：Ctrl+tab移到下一个buffer并在当前窗口打开；Ctrl+Shift+tab移到上一个buffer并在当前窗口打开；
	let g:miniBufExplModSelTarget = 1       " 不要在不可编辑内容的窗口（如TagList窗口）中打开选中的buffer

	"--代码折叠设置--
	set foldmethod=syntax               " 用语法高亮来定义折叠
	set foldlevel=100                   " 启动vim时不要自动折叠代码
	set foldcolumn=5                    " 设置折叠栏宽度

	"-- Cscope 设置 --
	if has("cscope")
		set csprg=/usr/bin/cscope        " 指定用来执行cscope的命令
		set csto=0                       " 设置cstag命令查找次序：
		set cst                          " 同时搜索cscope数据库和标签文件
		set cscopequickfix=s-,c-,d-,i-,t-,e-    " 使用QuickFix窗口来显示cscope查找结果
		set nocsverb
		if filereadable("cscope.out")    " 若当前目录下存在cscope数据库，添加该数据库到vim
			cs add cscope.out
		elseif $CSCOPE_DB != ""          " 否则只要环境变量CSCOPE_DB不为空，则添加其指定的数据库到vim
			cs add $CSCOPE_DB
		endif
		set csverb
	endif
	map <F4> :cs add ./cscope.out .<CR><CR><CR> :cs reset<CR>
	imap <F4> <ESC>:cs add ./cscope.out .<CR><CR><CR> :cs reset<CR>
	nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR> :copen<CR><CR>
	nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
	nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR> :copen<CR><CR>
	nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR> :copen<CR><CR>
	nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR> :copen<CR><CR>
	nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR> :copen<CR><CR>
	nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
	nmap <C-_>i :cs find i <C-R>=expand("<cfile>")<CR><CR> :copen<CR><CR>

	"--高亮设置--
	set cursorline
	set cursorcolumn

