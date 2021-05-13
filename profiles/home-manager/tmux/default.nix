{ config, pkgs, lib, ... }:

{
  programs = {
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
        bind S swap-window
        set -g default-command "${pkgs.zsh}/bin/zsh"
        set-option -sa terminal-overrides ',alacritty:RGB'
        set-option -g focus-events on

        set -g status-justify "left"
        set -g status "on"
        set -g status-left-style "none"
        set -g message-command-style "fg=colour254,bg=colour237"
        set -g status-right-style "none"
        set -g pane-active-border-style "fg=colour143"
        set -g status-style "none,bg=colour235"
        set -g message-style "fg=colour254,bg=colour237"
        set -g pane-border-style "fg=colour237"
        set -g status-right-length "100"
        set -g status-left-length "100"
        setw -g window-status-activity-style "none,fg=colour143,bg=colour235"
        setw -g window-status-separator ""
        setw -g window-status-style "none,fg=colour173,bg=colour235"
        set -g status-left "#[fg=colour235,bg=colour143] #S "
        set -g status-right "#[fg=colour173,bg=colour235] #(${pkgs.my.utils}/bin/kubestate) | %a %d %b #[fg=colour254,bg=colour237] %R #[fg=colour143,bg=colour237]#[fg=colour235,bg=colour143] #h "
        setw -g window-status-format "#[default] #I #W#F "
        setw -g window-status-current-format "#[fg=colour254,bg=colour237] #I #W#F "
      '';
    };
  };
}
