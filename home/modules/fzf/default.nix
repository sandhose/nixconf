{ ... }:

{
  programs.fzf = {
    enable = true;
    historyWidgetOptions = [
      "--layout=reverse"
      "--inline-info"
    ];
  };
}
