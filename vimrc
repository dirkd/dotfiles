set nocompatible "do not use vi compatibiliy
set ttyfast

set nosmartindent "auto indent new lines
set encoding=utf-8 "text encoding
set number "show line numbers
set title "set xterm title

set rtp+=$GOROOT/misc/vim

let g:SuperTabDefaultCompletionType = "context"

call pathogen#infect() "pathogen runtimepath-handling

syntax on

colorscheme wombat256mod

if has('gui_running')
	set guioptions-=m "disable menu
	set guioptions-=T "disable toolbar
	set guioptions-=r "disable always-on right scrollbar
else
	set t_Co=256 "force 256 terminal colors
	set background=dark
endif

set noexpandtab "do not expand tabs to spaces
set tabstop=4 "tabstop length in spaces
set softtabstop=4
set shiftwidth=4

set wildmode=list:longest,full

set showcmd "show (partial) command in status line.
set showmatch "show matching brackets.
set incsearch "incremental search
set mouse=a "enable mouse usage (all modes)

filetype plugin indent on

autocmd FileType python setlocal et ts=8 tw=79

"autocomplete settings
set ofu=syntaxcomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

"template loading for new buffers
"http://vim.runpaint.org/typing/using-templates/
autocmd! BufNewFile * silent! 0r ~/.vim/skel/tmpl.%:e | $d
