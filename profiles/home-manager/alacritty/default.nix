{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;

    settings = {
      window = {
        startup_mode = "Maximized";
        dynamic_title = true;
      };

      font = {
        normal.family = "FiraCode Nerd Font";
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
