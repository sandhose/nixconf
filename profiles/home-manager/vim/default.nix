{ config, pkgs, lib, ... }:

let
  pluginWithDeps = plugin: deps: plugin.overrideAttrs (_: { dependencies = deps; });
  nvimHome = "${config.xdg.configHome}/nvim";
in
{
  programs = {
    neovim = {
      enable = true;
      vimAlias = true;
      package = pkgs.neovim;

      extraPackages = with pkgs; [
        neovim-remote
        gcc
        tree-sitter

        # Needed by Telescope
        bat
        fd
        ripgrep

        # Various language servers
        fenix.rust-analyzer
        nodePackages.bash-language-server
        clang-tools
        nodePackages.vscode-css-languageserver-bin
        nodePackages.dockerfile-language-server-nodejs
        gopls
        nodePackages.vscode-html-languageserver-bin
        nodePackages.pyright
        rnix-lsp
        terraform-ls
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

      plugins = with pkgs.vimPlugins;
        let
          telescope =
            (pluginWithDeps telescope-nvim [ plenary-nvim popup-nvim ]);
        in
          [
            pkgs.my.material-nvim # Color scheme
            undotree
            vim-fugitive
            vim-surround
            vim-easy-align
            editorconfig-vim

            plenary-nvim
            popup-nvim
            telescope

            nvim-lspconfig
            (
              nvim-treesitter.withPlugins (
                p: [
                  # TODO: package tree-sitter-comment
                  p.tree-sitter-bash
                  p.tree-sitter-c
                  p.tree-sitter-cpp
                  p.tree-sitter-css
                  p.tree-sitter-go
                  p.tree-sitter-html
                  p.tree-sitter-java
                  p.tree-sitter-javascript
                  p.tree-sitter-jsdoc
                  p.tree-sitter-json
                  # p.tree-sitter-lua # Broken
                  p.tree-sitter-markdown
                  p.tree-sitter-nix
                  p.tree-sitter-php
                  p.tree-sitter-python
                  p.tree-sitter-regex
                  p.tree-sitter-ruby
                  p.tree-sitter-rust
                  p.tree-sitter-tsx
                  p.tree-sitter-typescript
                  p.tree-sitter-yaml
                ]
              )
            )
            nvim-web-devicons
            (pluginWithDeps nvim-tree-lua [ nvim-web-devicons ])
            (pluginWithDeps gitsigns-nvim [ plenary-nvim ])
            (pluginWithDeps rust-tools-nvim [ telescope nvim-lspconfig ])
            (pluginWithDeps telescope-symbols-nvim [ telescope ])
            nvim-compe
            lsp-status-nvim
            vim-vsnip
            vim-vsnip-integ
            friendly-snippets
            lspkind-nvim
            galaxyline-nvim

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
        map (
          file: {
            name = "${nvimHome}/${file}";
            value = {
              source = ./config + "/${file}";
              recursive = true;
            };
          }
        ) (builtins.attrNames (builtins.readDir ./config))
      );
    in
      cfg // {
        "${nvimHome}/undo/.keep".text = "";
        "${nvimHome}/swaps/.keep".text = "";
        "${nvimHome}/backups/.keep".text = "";
      };
}
