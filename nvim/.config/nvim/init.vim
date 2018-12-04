" Leader key
let mapleader = ','
let g:mapleader = ','

" Keybinds
inoremap kj <Esc>

nnoremap <Leader>w :w<Cr>
nnoremap <Leader>sw :w !sudo tee %<Cr>

vnoremap < <gv
vnoremap > >gv

nnoremap <Leader>r :edit!<Cr>
nnoremap <Leader>a :nohl<Cr>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Line numbers
set number
set relativenumber

" Tabs and Spaces
set expandtab
set shiftwidth=4
set tabstop=4

set shiftround

" Backups
set nobackup
set noswapfile
set nowritebackup

" Searching
set ignorecase
set smartcase

" Misc
set cmdheight=2
set cursorline
set fileformats=unix,dos,mac
set lazyredraw
set matchtime=2
set showmatch
set smartindent

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
