{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;

    settings = {
      env = {
        TERM = "alacritty-direct";
      };

      window = {
        startup_mode = "Maximized";
        dynamic_title = true;
      };

      font = {
        normal.family = "monospace";
        offset.y = 2;
        size = 11;
      };

      shell = {
        program = "${pkgs.zsh}/bin/zsh";
        args = [ "--login" ];
      };
    };
  };
}
