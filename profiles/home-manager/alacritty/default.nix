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
        normal.family = "Fira Code";
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
