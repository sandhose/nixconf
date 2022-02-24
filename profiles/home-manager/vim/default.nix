{ config, pkgs, lib, ... }:

let
  nvimHome = "${config.xdg.configHome}/nvim";
in
{
  programs = {
    neovim = {
      enable = true;
      vimAlias = true;

      extraPackages = with pkgs; [
        gcc
        tree-sitter

        # Needed by Telescope
        bat
        fd
        ripgrep

        # For nvim-dap
        #lldb

        # Various language servers
        fenix.rust-analyzer
        nodePackages.bash-language-server
        # clang-tools # broken on darwin
        nodePackages.vscode-langservers-extracted
        nodePackages.dockerfile-language-server-nodejs
        nodePackages.pyright
        gopls
        # python38Packages.python-lsp-server
        # python38Packages.python-lsp-black
        rnix-lsp
        terraform-ls
        nodePackages.typescript
        nodePackages.typescript-language-server
        nodePackages.yaml-language-server

        # For null-ls.nvim
        actionlint
        nodePackages.prettier
        nodePackages.eslint_d
        shellcheck
        statix
      ];

      # Can't rely on init.lua, because it gets loaded before init.vim and
      # home-manager sets things like runtimepath and packpath in it
      # TODO: make that use ~/.local/share/nvim instead
      extraConfig = ''
        set backupdir=${nvimHome}/backups
        set directory=${nvimHome}/swaps
        set undodir=${nvimHome}/undo
        set shadafile=${nvimHome}/viminfo

        lua require'my'
        runtime config.vim
      '';

      plugins = with pkgs.vimPlugins; [
        gruvbox-nvim
        undotree
        vim-fugitive
        vim-surround
        vim-easy-align
        editorconfig-vim

        plenary-nvim
        popup-nvim
        telescope-nvim

        nvim-lspconfig
        (nvim-treesitter.withPlugins (grammars: [
          grammars.tree-sitter-bash
          grammars.tree-sitter-c
          grammars.tree-sitter-comment
          #grammars.tree-sitter-cpp
          grammars.tree-sitter-css
          grammars.tree-sitter-dart
          grammars.tree-sitter-dot
          #grammars.tree-sitter-fluent
          #grammars.tree-sitter-go
          grammars.tree-sitter-html
          grammars.tree-sitter-java
          grammars.tree-sitter-javascript
          grammars.tree-sitter-jsdoc
          grammars.tree-sitter-json
          grammars.tree-sitter-latex
          grammars.tree-sitter-lua
          grammars.tree-sitter-make
          #grammars.tree-sitter-markdown
          grammars.tree-sitter-nix
          grammars.tree-sitter-php
          grammars.tree-sitter-python
          grammars.tree-sitter-regex
          grammars.tree-sitter-rst
          grammars.tree-sitter-ruby
          grammars.tree-sitter-rust
          grammars.tree-sitter-svelte
          grammars.tree-sitter-toml
          grammars.tree-sitter-tsx
          grammars.tree-sitter-typescript
          grammars.tree-sitter-yaml
        ]))
        nvim-web-devicons
        nvim-tree-lua
        gitsigns-nvim
        telescope-symbols-nvim
        null-ls-nvim

        cmp-nvim-lsp
        cmp-buffer
        cmp-path
        cmp-cmdline
        cmp-calc
        cmp-vsnip
        nvim-cmp

        lsp-status-nvim
        vim-vsnip
        vim-vsnip-integ
        friendly-snippets
        lspkind-nvim
        lualine-nvim
        trouble-nvim

        nvim-dap
        telescope-dap-nvim
        rust-tools-nvim
        crates-nvim

        # lightline-vim

        vim-polyglot
        vim-jsonnet
        goyo-vim
      ];
    };
  };

  home.file =
    let
      # Symlink everything in ./config to ~/.config/nvim/
      cfg = builtins.listToAttrs (map
        (file: {
          name = "${nvimHome}/${file}";
          value = {
            source = ./config + "/${file}";
            recursive = true;
          };
        })
        (builtins.attrNames (builtins.readDir ./config)));
    in
    cfg // {
      "${nvimHome}/undo/.keep".text = "";
      "${nvimHome}/swaps/.keep".text = "";
      "${nvimHome}/backups/.keep".text = "";
    };
}
