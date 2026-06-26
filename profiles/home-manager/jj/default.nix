{ ... }:

{
  programs.jujutsu = {
    enable = true;
    settings = {
      remotes.origin.auto-track-bookmarks = "*";

      # Treat commits marked by `jj-mark-reviewed` (local `reviewed/pr-*`
      # bookmarks pointing at GitHub-reviewed commits) as immutable. These
      # bookmarks are local and untracked, so a plain `jj git push` never
      # pushes them.
      revset-aliases."immutable_heads()" = "builtin_immutable_heads() | bookmarks(glob:'reviewed/*')";

      ui = {
        pager = "delta";
        diff.format = "git";
      };

      # Named ANSI colors map through the terminal palette, so this works in
      # both Catppuccin Mocha and Latte. Defaults dim most of every ID to
      # "bright black" and reuse magenta for change_id/bookmarks/tags, which
      # makes the log hard to parse. Goals: make the unique ID prefix pop, and
      # give refs colors distinct from change IDs.
      colors = {
        # The unique prefix is what you select/type — make it unmistakable.
        prefix = {
          bold = true;
          underline = true;
        };
        change_id = "magenta";
        commit_id = "blue";
        rest = "bright black"; # tail of the hash; dim is fine once prefix pops

        # Don't let bookmarks/tags blend into change_ids (all magenta by default).
        bookmark = {
          fg = "green";
          bold = true;
        };
        bookmarks = {
          fg = "green";
          bold = true;
        };
        local_bookmarks = {
          fg = "green";
          bold = true;
        };
        remote_bookmarks = "bright green";
        tags = {
          fg = "yellow";
          bold = true;
        };
        git_head = {
          fg = "bright green";
          bold = true;
        };

        author = {
          fg = "yellow";
          bold = true;
        };
        timestamp = "cyan";

        working_copy = {
          bold = true;
        };
      };
    };
  };
}
