{ pkgs, ... }:

{
  imports = [ ./system.nix ];
  environment = {
    systemPackages = with pkgs; [
      postgresql_12
      pinentry_mac
      reattach-to-user-namespace
      notmuch
      my.neomutt
      msmtp
      wireshark
      xquartz
    ];

    variables = {
      EDITOR = "${pkgs.neovim}/bin/nvim";
      LANG = "en_US.UTF-8";
    };
  };

  programs.nix-index.enable = true;
  services.nix-daemon.enable = true;
  fonts.enableFontDir = true;

  users.users = {
    sandhose = {
      description = "Quentin Gliech";
      shell = pkgs.zsh;
      home = "/Users/sandhose";
    };
  };

  system.stateVersion = 4;
}
