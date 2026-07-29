{ pkgs, ... }:

{
  #fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    # nerdfonts # 6+GB
    my.virgil
  ];
}
