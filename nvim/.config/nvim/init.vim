set runtimepath+=/home/buffet/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
    call dein#begin('~/.cache/dein')

    call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

    call dein#add('godlygeek/tabular')
    call dein#add('chriskempson/base16-vim')
    call dein#add('kien/ctrlp.vim')
    call dein#add('ervandew/supertab')

    call dein#end()
    call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

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

nnoremap <Leader><Tab> /<++><Cr>:nohl<Cr>"_c4l
inoremap <Leader><Tab> <Esc>/<++><Cr>:nohl<Cr>"_c4l

nnoremap <Leader>lm magg0<Esc>:r ~/dotfiles/misc/licenses/mpl20<Cr>kdd`a

nnoremap <Leader>. :CtrlPTag<Cr>

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
colorscheme base16-atelier-dune-light

filetype plugin indent on
syntax enable

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

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
