colorscheme solarized   " solarized theme
set background=dark     " dark mode

syntax enable           " enable syntax processing
filetype indent on      " load filetype-specific indent files

set tabstop=4           " number of visual spaces per TAB
set softtabstop=4       " number of spaces in tab when editing
set shiftwidth=4        " when indenting with '>', use 4 spaces width
set expandtab           " tabs are spaces

set cursorline          " highlight current line
set number              " show line numbers

set showmatch           " highlight matching [{()}]

set incsearch           " search as characters are entered
set hlsearch            " highlight matches

set wildmenu            " visual autocomplete for command menu

set clipboard=unnamed

" vim-airline solarized theme
let g:airline_solarized_bg='dark'
let g:airline_theme='solarized'
