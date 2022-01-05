{ pkgs, inputs, config, ... }:

with inputs; {
  imports = [ ./system.nix ];

  environment = {
    systemPackages = with pkgs; [
      postgresql_12
      pinentry_mac
      reattach-to-user-namespace
      notmuch
      #my.neomutt
      neomutt
      msmtp
      #wireshark
      xquartz
      ncurses
      cocoapods
    ];

    variables = {
      EDITOR = "${pkgs.neovim}/bin/nvim";
      LANG = "en_US.UTF-8";
      TERMINFO = "/etc/terminfo";
    };

    pathsToLink = [ "/share/terminfo" ];
    extraOutputsToInstall = [ "terminfo" ];

    etc.terminfo = { source = "${config.system.path}/share/terminfo"; };
  };

  programs.nix-index.enable = true;
  services.nix-daemon.enable = true;
  fonts.enableFontDir = true;
  users.nix.configureBuildUsers = true;

  system.stateVersion = 4;
}
