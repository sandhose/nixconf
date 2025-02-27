{ pkgs, inputs, config, ... }:

with inputs; {
  imports = [ ./system.nix ];

  environment = {
    systemPackages = with pkgs; [
      lima-bin
      postgresql_16
      postgresql_16.lib
      (hiPrio postgresql_16.dev)
      openssl
      openssl.dev
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
      COREPACK_ENABLE_AUTO_PIN = "0"; # Disable yarn automatically pinning itself in the package.json
    };

    pathsToLink = [ "/share/terminfo" "/share/pkgconfig" "/include" "/lib" ];
    extraOutputsToInstall = [ "terminfo" ];

    etc.terminfo = { source = "${config.system.path}/share/terminfo"; };
  };

  security.pam.services.sudo_local = {
    enable = true;
    touchIdAuth = true;
  };

  programs.nix-index.enable = true;

  system.stateVersion = 4;
}
