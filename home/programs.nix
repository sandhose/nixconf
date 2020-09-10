{ pkgs, ... }:
with builtins; {
  git = {
    enable = true;
    aliases = {
      lg = "log --graph --pretty=format:'%C(yellow)%d%Creset %C(cyan)%h%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=short --all";
    };
    ignores = [".DS_Store" "*.swp" ".venv" ".tern-port" ".pyre" ".mypy_cache"];

    signing = {
      key = "552719FC";
      signByDefault = true;
    };

    extraConfig = {
      pull.rebase = true;
      rebase.autoStash = true;
    };

    userEmail = "quentingliech@gmail.com";
    userName = "Quentin Gliech";
  };

  fzf = {
    enable = true;
    historyWidgetOptions = [
      "--layout=reverse"
      "--inline-info"
    ];
  };

  zsh = {
    enable = true;

    autocd = true;
    defaultKeymap = "emacs";

    history = {
      extended = true;
      save = 10000;
      size = 10000;
      share = true;
      expireDuplicatesFirst = true;
    };

    shellAliases = {
      zmv = "noglob zmv -W";
      dr = "docker run -it --rm";
    };

    plugins = [{
      name = "base16-shell";
      src = pkgs.fetchFromGitHub {
        owner = "chriskempson";
        repo = "base16-shell";
        rev = "ce8e1e5";
        sha256 = "1yj36k64zz65lxh28bb5rb5skwlinixxz6qwkwaf845ajvm45j1q";
      };
    }];

    initExtra = readFile ./files/additional.zsh;
  };

  neovim = {
    enable = true;
    vimAlias = true;

    extraConfig = (readFile ./files/vimrc);

    plugins = with pkgs.vimPlugins; [
      undotree
      nerdtree
      nerdtree-git-plugin
      vim-fugitive
      # vim-gitgutter
      vim-surround
      vim-easy-align
      # supertab
      editorconfig-vim
      # ale
      fzf-vim
      # LanguageClient-neovim
      # ncm2
      # nvim-yarp
      # ncm2-bufword
      # ncm2-path
      # ncm2-ultisnips
      # ncm2-go

      coc-nvim
      coc-git
      coc-highlight
      coc-html
      coc-json
      coc-snippets
      coc-tsserver
      coc-tslint-plugin
      coc-prettier
      coc-css
      coc-python
      coc-yank
      coc-jest
      coc-eslint
      coc-lists
      coc-yaml
      coc-stylelint

      coc-fzf
      coc-rust-analyzer
      # coc-go

      ultisnips
      vim-snippets
      # andrewstuart/vim-kubernetes
      vim-airline
      base16-vim
      vim-airline-themes
      # edkolev/tmuxline.vim
      vim-polyglot
      yats-vim
      vim-jsonnet
      # typescript-vim
      # vim-jsx-pretty
      # vim-go
      # vim-scripts/scons.vim
      # flowtype/vim-flow
      # vim-scripts/coq-syntax
      # andreshazard/vim-freemarker
      # jparise/vim-graphql
      # Harenome/vim-mipssyntax
      # fremff/vim-css-syntax
      # vim-scripts/lbnf.vim
      # leafo/moonscript-vim
      # quabug/vim-gdscript
      # jxnblk/vim-mdx-js
      # b4b4r07/vim-hcl
      # tpope/vim-db
      # stfl/meson.vim
      goyo-vim
      limelight-vim
      # vim-indent-guides
    ];
  };

  tmux = {
    enable = true;
    sensibleOnTop = false;
    shortcut = "a";
    terminal = "screen-256color";
    escapeTime = 50;
    clock24 = true;
    aggressiveResize = true;
    secureSocket = false;

    extraConfig = ''
      set -g mouse on
      bind R move-window -r
      bind P attach -c "#{pane_current_path}"
      bind S swap-window
      set -g default-command "${pkgs.zsh}/bin/zsh"

      set -g status-justify "left"
      set -g status "on"
      set -g status-left-style "none"
      set -g message-command-style "fg=colour254,bg=colour237"
      set -g status-right-style "none"
      set -g pane-active-border-style "fg=colour143"
      set -g status-style "none,bg=colour235"
      set -g message-style "fg=colour254,bg=colour237"
      set -g pane-border-style "fg=colour237"
      set -g status-right-length "100"
      set -g status-left-length "100"
      setw -g window-status-activity-style "none,fg=colour143,bg=colour235"
      setw -g window-status-separator ""
      setw -g window-status-style "none,fg=colour173,bg=colour235"
      set -g status-left "#[fg=colour235,bg=colour143] #S "
      set -g status-right "#[fg=colour173,bg=colour235] #(${pkgs.myutils}/bin/kubestate) | %a %d %b #[fg=colour254,bg=colour237] %R #[fg=colour143,bg=colour237]#[fg=colour235,bg=colour143] #h "
      setw -g window-status-format "#[default] #I #W#F "
      setw -g window-status-current-format "#[fg=colour254,bg=colour237] #I #W#F "
    '';
  };

  npm = {
    enable = true;
    npmrc = {
      enable = true;
      # followXDG = true;
    };

    prefix = ".local/lib/node_modules";
  };
}
