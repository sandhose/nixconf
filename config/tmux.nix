{
  enable = true;
  enableMouse = true;
  enableFzf = true;

  tmuxConfig = ''
      # remap prefix to Control + a
      unbind C-b
      set-option -g prefix C-a
      # pass through a ctrl-a if you press it twice
      bind C-a send-prefix
      # 256 color
      set -g default-terminal "screen-256color"

      set -s escape-time 10
      set -g focus-events off
      setw -g aggressive-resize on
      set -g status-keys emacs

      bind R move-window -r
      bind P attach -c "#{pane_current_path}"

      source -q ~/.tmuxline-theme.conf
  '';
}
