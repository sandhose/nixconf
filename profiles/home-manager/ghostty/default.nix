{ pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    package = pkgs.hello; # TODO: we don't want to actually install it, only have the config
    installVimSyntax = false;
    installBatSyntax = false;
    enableBashIntegration = true;
    enableZshIntegration = true;

    settings = {
      theme = "dark:catppuccin-mocha,light:catppuccin-latte";
      unfocused-split-opacity= "0.9";
      auto-update = "download";

      keybind = [
        "ctrl+a>c=new_tab"
        "ctrl+a>n=next_tab"
        "ctrl+a>p=previous_tab"
        "ctrl+a>s=new_split:right"
        "ctrl+a>shift+ù=new_split:right"
        "ctrl+a>\"=new_split:down"
        "ctrl+a>left=goto_split:left"
        "ctrl+a>right=goto_split:right"
        "ctrl+a>up=goto_split:top"
        "ctrl+a>down=goto_split:bottom"
        "ctrl+a>z=toggle_split_zoom"
        "ctrl+a>space=equalize_splits"
      ];
    };
  };
}
