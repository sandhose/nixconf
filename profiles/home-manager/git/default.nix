{ ... }:

{
  programs = {
    delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        hyperlinks = true;
        navigate = true;
        side-by-side = true;
        syntax-theme = "ansi";
        colorMoved = "default";
      };
    };

    git = {
      enable = true;
      lfs.enable = true;
      ignores = [
        ".DS_Store"
        "*.swp"
        ".venv"
        ".tern-port"
        ".pyre"
        ".mypy_cache"
        ".envrc"
        ".direnv/"
        ".zed/"
      ];

      settings = {
        alias = {
          lg = "log --graph --pretty=format:'%C(yellow)%d%Creset %C(cyan)%h%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=short --all";
        };
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
