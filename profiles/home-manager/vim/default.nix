{
  config,
  pkgs,
  lib,
  ...
}:

let
  nvimHome = "${config.xdg.configHome}/nvim";
  nvim-spell-fr-utf8-dictionary = builtins.fetchurl {
    url = "https://ftp.nluug.nl/vim/runtime/spell/fr.utf-8.spl";
    sha256 = "abfb9702b98d887c175ace58f1ab39733dc08d03b674d914f56344ef86e63b61";
  };

  nvim-spell-fr-utf8-suggestions = builtins.fetchurl {
    url = "https://ftp.nluug.nl/vim/runtime/spell/fr.utf-8.sug";
    sha256 = "0294bc32b42c90bbb286a89e23ca3773b7ef50eff1ab523b1513d6a25c6b3f58";
  };

  nvim-spell-fr-latin1-dictionary = builtins.fetchurl {
    url = "https://ftp.nluug.nl/vim/runtime/spell/fr.latin1.spl";
    sha256 = "086ccda0891594c93eab143aa83ffbbd25d013c1b82866bbb48bb1cb788cc2ff";
  };

  nvim-spell-fr-latin1-suggestions = builtins.fetchurl {
    url = "https://ftp.nluug.nl/vim/runtime/spell/fr.latin1.sug";
    sha256 = "5cb2c97901b9ca81bf765532099c0329e2223c139baa764058822debd2e0d22a";
  };
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

        # Various language servers
        nodePackages.bash-language-server
        clang-tools # broken on darwin
        nodePackages.vscode-langservers-extracted
        nodePackages.dockerfile-language-server-nodejs
        pyright
        gopls
        # python38Packages.python-lsp-server
        # python38Packages.python-lsp-black
        terraform-ls
        nil
        nodePackages.typescript
        nodePackages.typescript-language-server
        nodePackages.yaml-language-server
        #zls
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

      extraLuaPackages = ps: [
        ps.nvim-nio # nvim-dap dependency
      ];

      plugins = with pkgs.vimPlugins; [
        gruvbox-nvim
        undotree
        vim-fugitive
        vim-rhubarb
        vim-surround
        vim-easy-align
        editorconfig-vim

        plenary-nvim
        popup-nvim
        telescope-nvim

        nvim-lspconfig
        (nvim-treesitter.withPlugins (grammars: [
          grammars.tree-sitter-astro
          grammars.tree-sitter-bash
          grammars.tree-sitter-c
          grammars.tree-sitter-comment
          grammars.tree-sitter-cpp
          grammars.tree-sitter-css
          grammars.tree-sitter-dart
          grammars.tree-sitter-dot
          grammars.tree-sitter-dockerfile
          grammars.tree-sitter-graphql
          grammars.tree-sitter-go
          grammars.tree-sitter-hcl
          grammars.tree-sitter-html
          grammars.tree-sitter-java
          grammars.tree-sitter-javascript
          grammars.tree-sitter-jsdoc
          grammars.tree-sitter-json
          grammars.tree-sitter-latex
          grammars.tree-sitter-lua
          grammars.tree-sitter-make
          grammars.tree-sitter-markdown
          grammars.tree-sitter-nix
          grammars.tree-sitter-php
          grammars.tree-sitter-python
          grammars.tree-sitter-regex
          grammars.tree-sitter-rego
          grammars.tree-sitter-rst
          grammars.tree-sitter-ruby
          grammars.tree-sitter-rust
          grammars.tree-sitter-svelte
          grammars.tree-sitter-toml
          grammars.tree-sitter-tsx
          grammars.tree-sitter-typescript
          grammars.tree-sitter-yaml
          grammars.tree-sitter-zig
        ]))
        nvim-web-devicons
        nvim-tree-lua
        gitsigns-nvim
        telescope-symbols-nvim
        #none-ls-nvim
        dressing-nvim
        fidget-nvim
        nvim-treesitter-context

        supermaven-nvim

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
        symbols-outline-nvim
        satellite-nvim
        hover-nvim

        nvim-dap
        nvim-dap-ui
        telescope-dap-nvim
        rustaceanvim
        crates-nvim

        neotest

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
      cfg = builtins.listToAttrs (
        map (file: {
          name = "${nvimHome}/${file}";
          value = {
            source = ./config + "/${file}";
            recursive = true;
          };
        }) (builtins.attrNames (builtins.readDir ./config))
      );
    in
    cfg
    // {
      "${nvimHome}/undo/.keep".text = "";
      "${nvimHome}/swaps/.keep".text = "";
      "${nvimHome}/backups/.keep".text = "";
      "${nvimHome}/spell/fr.utf-8.spl".source = nvim-spell-fr-utf8-dictionary;
      "${nvimHome}/spell/fr.utf-8.sug".source = nvim-spell-fr-utf8-suggestions;
      "${nvimHome}/spell/fr.latin1.spl".source = nvim-spell-fr-latin1-dictionary;
      "${nvimHome}/spell/fr.latin1.sug".source = nvim-spell-fr-latin1-suggestions;
    };
}
