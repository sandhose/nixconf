{ ... }:

{
  programs.jujutsu = {
    enable = true;
    settings = {
      remotes.origin.auto-track-bookmarks = "*";

      ui = {
        pager = "delta";
        diff.format = "git";
      };
    };
  };
}
