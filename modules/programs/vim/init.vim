" Load plugins *before* my config
packloadall

" Basic Config

filetype plugin indent on
syntax on

set mouse=a
set undodir=~/.cache/vim-undodir
set undofile
set shortmess+=c " don't show 'match 1 or 2' or 'the only match'
set hidden
set encoding=utf-8
set cursorline
set hlsearch
set incsearch
set inccommand=nosplit
set ignorecase
set smartcase
set completeopt=longest,menuone,preview
set laststatus=2
set lazyredraw
set splitbelow
set splitright
set matchtime=2
set showmatch
set nowrap
set nowritebackup
set noshowmode
set updatetime=300
set signcolumn=yes


" Keybinds

"" unmap

" any-jump
autocmd! VimEnter * :unmap <Space>ab
autocmd! VimEnter * :unmap <Space>al
autocmd! VimEnter * :unmap <Space>j


let mapleader = "\<Space>"
let g:mapleader = "\<Space>"

inoremap kj <Esc>

vnoremap < <gv
vnoremap > >gv


"" yoink

nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)

nmap y <plug>(YoinkYankPreserveCursorPosition)
xmap y <plug>(YoinkYankPreserveCursorPosition)

nmap <c-=> <plug>(YoinkPostPasteToggleFormat)


"" which-key

set timeoutlen=250

nnoremap <silent> <leader> :<C-u>WhichKey '<Space>'<Cr>
vnoremap <silent> <leader> :<C-u>WhichKeyVisual '<Space>'<Cr>

let g:which_key_map = {
    \ "\<Space>" : [':Files',                                'find-file'],
    \ "r"        : [':Rg',                                   'ripgrep'],
    \ 'b'        : [':Buffers',                              'select-buffer'],
    \ 'w'        : [':w',                                    'save-file'],
    \ '['        : ['<plug>(YoinkPostPasteSwapBack)',        'yoink-back'],
    \ ']'        : ['<plug>(YoinkPostPasteSwapForward)',     'yoink-fwd'],
    \ 't'        : { 'name': '+toggle',
                   \ 'i'   : [':IndentGuidesToggle',         'indent-guides'],
                   \ },
    \ 'l'        : { 'name': '+lsp',
                   \ 'r'   : ['<plug>(coc-rename)',          'rename'],
                   \ 'f'   : ['<plug>(coc-format-selected)', 'format'],
                   \ 'a'   : ['<plug>(coc-codeaction-selected)', 'action'],
                   \ 'A'   : ['<plug>(coc-codeaction)',      'action (buffer)'],
                   \ 'q'   : ['<plug>(coc-fix-current)',     'fix'],
                   \ }
    \ }

call which_key#register('<Space>', "g:which_key_map")

xmap <leader>lf <plug>(coc-format-selected)
xmap <leader>la <plug>(coc-codeaction-selected)


" Indentation

set shiftwidth=4
set tabstop=4
set backspace=indent,eol,start
set shiftround
set autoindent
set smartindent
set expandtab


" Theme Stuff

set background=light
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ }
colorscheme solarized
hi LineNr ctermbg=NONE guibg=NONE
hi Comment cterm=italic
set fillchars+=vert:│
hi VertSplit ctermbg=bg guibg=bg
hi SignColumn ctermbg=bg guibg=bg
hi SignifySignAdd ctermbg=bg guibg=bg
hi SignifySignChange ctermbg=bg guibg=bg
hi SignifySignDelete ctermbg=bg guibg=bg
hi SignifySignDeleteFirstLine ctermbg=bg guibg=bg

hi ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

let g:signify_sign_add               = '▍'
let g:signify_sign_delete            = '▍'
let g:signify_sign_delete_first_line = '▍'
let g:signify_sign_change            = '▍'
let g:signify_sign_show_text = 1


augroup basics
    autocmd!
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o " Disable automatic comment on new line
augroup END


" Split Navigation

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l


" CoC

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
