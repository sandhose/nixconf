{ ... }:

{
  programs = {
    git = {
      enable = true;
      lfs.enable = true;
      delta = {
        enable = true;
        options = {
          hyperlinks = true;
          navigate = true;
          side-by-side = true;
          syntax-theme = "ansi";
          colorMoved = "default";
        };
      };
      aliases = {
        lg =
          "log --graph --pretty=format:'%C(yellow)%d%Creset %C(cyan)%h%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=short --all";
      };
      ignores = [
        ".DS_Store"
        "*.swp"
        ".venv"
        ".tern-port"
        ".pyre"
        ".mypy_cache"
        ".envrc"
        ".direnv/"
      ];

      extraConfig = {
        column.ui = "auto";
        branch.sort = "-committerdate";
        tag.sort = "version:refname";
        pull.rebase = true;
        push = {
          default = "simple";
          autoSetupRemote = true;
        };
        rebase = {
          autoStash = true;
          autoSquash = true;
          updateRefs = true;
        };
        diff = {
          algorithm = "histogram";
          colorMoved = "plain";
          mnemonicPrefix = true;
          renames = true;
        };
        init.defaultBranch = "main";
        help.autocorrect = "prompt";
        commit.verbose = true;
        rerere = {
          enabled = true;
          autoupdate = true;
        };
        merge.conflictstyle = "zdiff3";
        fetch = {
          prune = true;
          pruneTags = false;
          all = true;
        };
      };
    };
  };
}
