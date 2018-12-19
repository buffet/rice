{ config, pkgs, ... }:

let dotdir = "/home/buffet/dotfiles";
in
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home = {
    file.".config/sway/config".source = "${dotdir}/sway/.config/sway/config";

    packages = with pkgs; [
      exa
      neofetch
      ranger
      ripgrep
    ];

    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  programs.chromium = {
    enable = true;
    extensions = [
      "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
      "dbepggeogbaibhgnhhndojpepiihcmeb" # Vimium
    ];
  };

  programs.git = {
    enable = true;
    aliases = {
      c = "commit --verbose";
      cm = "commit --verbose -m";
      m = "commit --ammend --verbose";
      s = "status -s";
      co = "checkout";
      cob = "checkout -b";
      b = "!git for-each-ref --sort='-authordate' --format='%(authordate)%09%(objectname:short)%09%(refname)' refs/heads | sed -e 's-refs/heads/--'";
    };
    extraConfig = ''
      [url "https://github.com/"]
        insteadOf = "gh:"
      [url "https://gitlab.com/"]
        insteadOf = "gl:"
    '';
    userEmail = "niclas@countingsort.com";
    userName = "buffet";
  };

  programs.tmux = {
    enable = true;
    extraConfig = ''
      # New prefix
      set -g prefix C-a
      unbind C-b
      bind-key C-a send-prefix

      # Smart pane switching with awareness of Vim splits.
      # See: https://github.com/christoomey/vim-tmux-navigator
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
      | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
      bind-key -n C-h if-shell "$is_vim" "send-keys C-h"  "select-pane -L"
      bind-key -n C-j if-shell "$is_vim" "send-keys C-j"  "select-pane -D"
      bind-key -n C-k if-shell "$is_vim" "send-keys C-k"  "select-pane -U"
      bind-key -n C-l if-shell "$is_vim" "send-keys C-l"  "select-pane -R"
      bind-key -n C-\ if-shell "$is_vim" "send-keys C-\\" "select-pane -l"
      bind-key -T copy-mode-vi C-h select-pane -L
      bind-key -T copy-mode-vi C-j select-pane -D
      bind-key -T copy-mode-vi C-k select-pane -U
      bind-key -T copy-mode-vi C-l select-pane -R
      bind-key -T copy-mode-vi C-\ select-pane -l

      # Easier splitting
      bind | split-window -h
      bind - split-window -v

      # No status bar
      set -g status off

      # st fix
      set -as terminal-overrides ',st*:Ss@'
    '';
  };

  programs.neovim = {
    enable = true;
    configure = {
      customRC = ''
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
        set foldmethod=syntax
        set cursorline
        set fileformats=unix,dos,mac
        set lazyredraw
        set matchtime=2
        set showmatch
        set smartindent
        " colorscheme base16-atelier-dune-light

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
      '';
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [
          base16-vim
          ctrlp-vim
          supertab
          tabular
          vim-tmux-navigator
        ];
      };
    };
    vimAlias = true;
  };

  programs.termite = {
    enable = true;
    font = "DejaVuSansMono";
  };

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    history.path = ".config/zsh/zsh_history";
    initExtra = ''
      PROMPT="[%F{green}%n%f@%F{green}%m %B%F{blue}%1~%b%f] "
    '';
    shellAliases = {
      e = "exa";
      eal = "exa -al";
      el = "exa -l";
      ra = "ranger";
      ta = "tmux attach-session -t";
      tkill = "tmux kill-session -t";
      tls = "tmux list-sessions";
      tnew = "tmux new -s";
      v = "nvim";
    };
  };
}
