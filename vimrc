colorscheme solarized   " solarized theme
set background=dark     " dark mode
let g:solarized_termtrans = 1
let g:solarized_termcolors = 16

syntax enable           " enable syntax processing
filetype indent on      " load filetype-specific indent files

set tabstop=4           " number of visual spaces per TAB
set softtabstop=4       " number of spaces in tab when editing
set shiftwidth=4        " when indenting with '>', use 4 spaces width
set expandtab           " tabs are spaces

set cursorline          " highlight current line

set showmatch           " highlight matching [{()}]

set incsearch           " search as characters are entered
set hlsearch            " highlight matches

set wildmenu            " visual autocomplete for command menu

set mouse=h             " enable mouse in help file

set list listchars=trail:·      " show trailing space

" show line numbers
"set number
" remove line numbers in insert mode
"autocmd InsertEnter * set nonumber
"autocmd InsertLeave * set number

" allowing copy/paste between application on all platforms
set clipboard^=unnamed,unnamedplus

" disable indentLine plugin
"let g:indentLine_loaded=1
" disable conceal for JSON and Markdown files
let g:vim_json_conceal=0
let g:markdown_syntax_conceal=0

" vim-airline solarized theme
let g:airline_solarized_bg='dark'
let g:airline_theme='solarized'
let g:airline_powerline_fonts=1
