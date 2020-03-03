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

    extraConfig = (readFile ./files/vimrc) + ''
      let g:LanguageClient_serverCommands = {
          \ 'javascript': ['${pkgs.nodePackages.typescript-language-server}/bin/typescript-language-server', '--stdio'],
          \ 'javascriptreact': ['${pkgs.nodePackages.typescript-language-server}/bin/typescript-language-server', '--stdio'],
          \ 'typescript': ['${pkgs.nodePackages.typescript-language-server}/bin/typescript-language-server', '--stdio'],
          \ 'typescriptreact': ['${pkgs.nodePackages.typescript-language-server}/bin/typescript-language-server', '--stdio'],
          \ 'graphql': ['${pkgs.nodePackages.graphql-lsp}/bin/graphql-lsp'],
          \ 'go': ['${pkgs.gotools}/bin/gopls'],
          \ }

      let g:ale_go_go_executable = '${pkgs.go}/bin/go'
      let g:ale_go_gopls_executable = '${pkgs.gotools}/bin/gopls'
      let g:ale_go_golint_executable = '${pkgs.golint}/bin/golint'
      let g:ale_go_gometalinter_executable = '${pkgs.gometalinter}/bin/gometalinter'
    '';

    plugins = with pkgs.vimPlugins; [
      undotree
      nerdtree
      nerdtree-git-plugin
      vim-fugitive
      vim-gitgutter
      vim-surround
      vim-easy-align
      supertab
      editorconfig-vim
      ale
      fzf-vim
      LanguageClient-neovim
      ncm2
      nvim-yarp
      ncm2-bufword
      ncm2-path
      ncm2-ultisnips
      # ncm2-go
      ultisnips
      vim-snippets
      # andrewstuart/vim-kubernetes
      vim-airline
      base16-vim
      vim-airline-themes
      # edkolev/tmuxline.vim
      vim-polyglot
      yats-vim
      # typescript-vim
      vim-jsx-pretty
      vim-go
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
      set -g default-command "${pkgs.zsh}/bin/zsh"

      source -q ~/.tmuxline-theme.conf
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
