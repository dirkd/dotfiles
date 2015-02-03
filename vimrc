"
" General
"
set nocompatible "do not use vi compatibiliy
set ttyfast

set encoding=utf-8 "text encoding
set number "show line numbers
set title "set xterm title

set wildmode=list:longest,full

set showcmd "show (partial) command in status line.
set showmatch "show matching brackets.
set incsearch "incremental search
set mouse=a "enable mouse usage (all modes)

"
" Plugins
"
call pathogen#infect() "pathogen runtimepath-handling

"
" Colors & Appearance
"
syntax on

if has('gui_running')
	set guioptions-=m "disable menu
	set guioptions-=T "disable toolbar
	set guioptions-=r "disable always-on right scrollbar
else
	set t_Co=256 "force 256 terminal colors
	set background=dark
endif

colorscheme wombat256mod

"
" Indentation
"
set nosmartindent "disable smartindent
set expandtab "expand tabs to spaces
set tabstop=8 "tabstop length in spaces
set softtabstop=4 "use 4 spaces for tabbing
set shiftwidth=4 "width of indentation

"
" Filetype recognition
"
filetype plugin indent on

autocmd FileType python setlocal et ts=8 sw=4 sts=4 tw=79
autocmd FileType go setlocal noet ts=8 sw=8 sts=0 tw=79

"
" Autocompletion
"
set ofu=syntaxcomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

"
" Template loading for new buffers
" http://vim.runpaint.org/typing/using-templates/
"
autocmd! BufNewFile * silent! 0r ~/.vim/skel/tmpl.%:e | $d

"
" Mappings
"
nnoremap <Leader>t :NERDTree<CR>

cmap W! w !sudo tee % >/dev/null
