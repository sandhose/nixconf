{ ... }:

{
  programs = {
    git = {
      enable = true;
      lfs.enable = true;
      delta = {
        enable = true;
        options = {
          navigate = true;
          side-by-side = true;
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
        pull.rebase = true;
        rebase.autoStash = true;
        init.defaultBranch = "main";
      };
    };
  };
}
