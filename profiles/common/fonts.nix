{ pkgs, ... }:

{
  #fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    my.virgil
  ];
}
