{ pkgs, inputs, config, ... }:

with inputs; {
  imports = [ ./system.nix ];

  environment = {
    systemPackages = with pkgs; [
      lima-bin
      postgresql_16
      postgresql_16.lib
      openssl.out
      pinentry_mac
      reattach-to-user-namespace
      #notmuch
      #my.neomutt
      #neomutt
      #msmtp
      #wireshark
      #xquartz # Broken as of 1/08/22
      (hiPrio ncurses)
      cocoapods
      qemu-utils
      docker
      docker-credential-helpers
      podman
      podman-compose
      buildkit
      libssh
    ];

    variables = {
      EDITOR = "nvim";
      LANG = "en_US.UTF-8";
      PKG_CONFIG_PATH = "/run/current-system/sw/share/pkgconfig:/run/current-system/sw/lib/pkgconfig";
      BUILDKIT_HOST = "podman-container://buildkitd";
    };

    pathsToLink = [ "/share/terminfo" "/share/pkgconfig" "/include" "/lib" ];
    extraOutputsToInstall = [ "terminfo" ];

    etc.terminfo = { source = "${config.system.path}/share/terminfo"; };
  };

  nix.configureBuildUsers = true;
  programs.nix-index.enable = true;
  services.nix-daemon.enable = true;

  system.stateVersion = 4;
}
