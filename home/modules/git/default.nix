{ ... }:

{
  programs = {
    git = {
      enable = true;
      aliases = {
        lg = "log --graph --pretty=format:'%C(yellow)%d%Creset %C(cyan)%h%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=short --all";
      };
      ignores = [".DS_Store" "*.swp" ".venv" ".tern-port" ".pyre" ".mypy_cache" ".envrc" ".direnv/"];

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
  };
}
