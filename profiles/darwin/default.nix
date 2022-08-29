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
      #xquartz # Broken as of 1/08/22
      ncurses
      cocoapods
    ];

    variables = {
      EDITOR = "nvim";
      LANG = "en_US.UTF-8";
      TERMINFO_DIRS = "/etc/terminfo";
    };

    pathsToLink = [ "/share/terminfo" ];
    extraOutputsToInstall = [ "terminfo" ];

    etc.terminfo = { source = "${config.system.path}/share/terminfo"; };
  };

  nix.configureBuildUsers = true;
  programs.nix-index.enable = true;
  services.nix-daemon.enable = true;

  system.stateVersion = 4;
}
