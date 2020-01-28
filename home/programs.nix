{ pkgs, config, ... }:
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
      vim = "${pkgs.neovim}/bin/nvim";
    };

    initExtra = ''
        source ${config.lib.base16.base16template "shell"}
    '' + readFile ./files/additional.zsh;
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

      source -q ~/.tmuxline-theme.conf
    '';
  };
}
