{ config, pkgs, lib, ... }:

let
  pluginWithDeps = plugin: deps: plugin.overrideAttrs (_: { dependencies = deps; });
  # TODO: remove after https://github.com/NixOS/nixpkgs/issues/144354 is closed
  fixGrammar = grammar: grammar.overrideAttrs (_: {
    fixupPhase = lib.optionalString pkgs.stdenv.isLinux ''
      runHook preFixup
      $STRIP $out/parser
      runHook postFixup
    '';
  });
  nvimHome = "${config.xdg.configHome}/nvim";
in
{
  programs = {
    neovim = {
      enable = true;
      vimAlias = true;
      package = pkgs.neovim;

      extraPackages = with pkgs; [
        gcc
        tree-sitter

        # Needed by Telescope
        bat
        fd
        ripgrep

        # For nvim-dap
        lldb

        # Various language servers
        fenix.rust-analyzer
        nodePackages.bash-language-server
        clang-tools
        nodePackages.vscode-langservers-extracted
        nodePackages.dockerfile-language-server-nodejs
        gopls
        nodePackages.pyright
        rnix-lsp
        terraform-ls
        nodePackages.typescript
        nodePackages.typescript-language-server
        nodePackages.yaml-language-server
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
          (pluginWithDeps gruvbox-nvim [ lush-nvim ])
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
              grammars:
              [
                (fixGrammar grammars.tree-sitter-bash)
                (fixGrammar grammars.tree-sitter-c)
                (fixGrammar grammars.tree-sitter-comment)
                #(fixGrammar grammars.tree-sitter-cpp)
                (fixGrammar grammars.tree-sitter-css)
                (fixGrammar grammars.tree-sitter-dart)
                (fixGrammar grammars.tree-sitter-dot)
                #(fixGrammar grammars.tree-sitter-fluent)
                (fixGrammar grammars.tree-sitter-go)
                (fixGrammar grammars.tree-sitter-html)
                (fixGrammar grammars.tree-sitter-java)
                (fixGrammar grammars.tree-sitter-javascript)
                (fixGrammar grammars.tree-sitter-jsdoc)
                (fixGrammar grammars.tree-sitter-json)
                (fixGrammar grammars.tree-sitter-latex)
                (fixGrammar grammars.tree-sitter-lua)
                (fixGrammar grammars.tree-sitter-make)
                (fixGrammar grammars.tree-sitter-markdown)
                (fixGrammar grammars.tree-sitter-nix)
                (fixGrammar grammars.tree-sitter-php)
                (fixGrammar grammars.tree-sitter-python)
                (fixGrammar grammars.tree-sitter-regex)
                (fixGrammar grammars.tree-sitter-rst)
                (fixGrammar grammars.tree-sitter-ruby)
                (fixGrammar grammars.tree-sitter-rust)
                (fixGrammar grammars.tree-sitter-svelte)
                (fixGrammar grammars.tree-sitter-toml)
                (fixGrammar grammars.tree-sitter-tsx)
                (fixGrammar grammars.tree-sitter-typescript)
                (fixGrammar grammars.tree-sitter-yaml)
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
          lualine-nvim
          trouble-nvim

          nvim-dap
          telescope-dap-nvim
          rust-tools-nvim

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
        map
          (
            file: {
              name = "${nvimHome}/${file}";
              value = {
                source = ./config + "/${file}";
                recursive = true;
              };
            }
          )
          (builtins.attrNames (builtins.readDir ./config))
      );
    in
    cfg // {
      "${nvimHome}/undo/.keep".text = "";
      "${nvimHome}/swaps/.keep".text = "";
      "${nvimHome}/backups/.keep".text = "";
    };
}
