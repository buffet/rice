" Leader key
let mapleader = ','
let g:mapleader = ','

" Keybinds
inoremap kj <Esc>
tnoremap <C-k><C-j> <C-\><C-n>

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

nnoremap <Leader><Tab> /<++><Cr>:nohl<Cr>"_c4l
inoremap <Leader><Tab> <Esc>/<++><Cr>:nohl<Cr>"_c4l

nnoremap <Leader>lm magg0<Esc>:r ~/dotfiles/misc/licenses/mpl20<Cr>kdd`a

nnoremap <Leader>. :CtrlPTag<Cr>

nnoremap <Leader>c :!compile <C-r>%<Cr>

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
set cursorline
set fileformats=unix,dos,mac
set lazyredraw
set matchtime=2
set showmatch
set smartindent
colorscheme base16-atelier-dune-light
set termguicolors
set fillchars+=vert:│
highlight VertSplit ctermbg=bg guibg=bg

filetype plugin indent on
syntax enable

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" NERDTree
map <C-n> :NERDTreeToggle<CR>

"" Close vim if NERDTree is the last window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"" For dirs
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" Language stuff

" LaTeX
function! s:latex_mappings()
    inoremap ;sec \section{}<cr><cr><++><esc>2kf}i
    inoremap ;ssec \subsection{}<cr><cr><++><esc>2kf}i
    inoremap ;sssec \subsubsection{}<cr><cr><++><esc>2kf}i

    inoremap ;up \usepackage{}<esc>i
    inoremap ;m \( \)<++><esc>T(i<space>
    inoremap ;M \[ \]<cr><cr><++><esc>kk$T[i<space>
    inoremap ;v <space>\)<esc>BBi\( <esc>f)a
    inoremap ^^ ^{}<++><esc>F}i
    inoremap __ _{}<++><esc>F}i

    inoremap ;be <esc>"ayiWi\begin{<esc>Ea}<cr>\end{<esc>"apa}<cr><++><esc>2ko

    inoremap ;8 \infty

    inoremap ;it \textit{}<++><esc>F}i
    inoremap ;bf \textbf{}<++><esc>F}i
    inoremap ;tt \texttt{}<++><esc>F}i
    inoremap ;ul \underline{}<++><esc>F}i
    inoremap ;em \emph{}<++><esc>F}i

    inoremap ;frac \frac{}{<++>}<++><esc>2F{a

    " build
    nnoremap <F5> :! latexmk -pdf <c-r>%<cr>
endfunction

autocmd BufNewFile,BufRead *.tex call s:latex_mappings()

" C/C++

function! s:insert_include_guards()
    let guardname = substitute(toupper(expand("%:t")), "\\.", "_", "g")
    execute "normal! i#ifndef " . guardname
    execute "normal! o#define " . guardname
    execute "normal! o"
    execute "normal! o"
    execute "normal! o"
    execute "normal! Go#endif /* " . guardname . " */"
    normal! kk
endfunction

autocmd BufNewFile *.{h,hpp,hxx} call <SID>insert_include_guards()
