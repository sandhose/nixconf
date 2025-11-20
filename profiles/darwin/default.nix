{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:

with inputs;
{
  imports = [ ./system.nix ];

  environment = {
    systemPackages = with pkgs; [
      (lima.override {
        withAdditionalGuestAgents = true;
      })
      postgresql_16
      postgresql_16.lib
      (lib.hiPrio postgresql_16.dev)
      postgresql_16.pg_config
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
      (lib.hiPrio ncurses)
      cocoapods
      docker
      docker-compose
      docker-buildx
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
      CLICOLOR = "1";
    };

    pathsToLink = [
      "/share/terminfo"
      "/share/pkgconfig"
      "/include"
      "/lib"
    ];
    extraOutputsToInstall = [ "terminfo" ];

    etc.terminfo = {
      source = "${config.system.path}/share/terminfo";
    };
  };

  security.pam.services.sudo_local = {
    enable = true;
    touchIdAuth = true;
  };

  programs.nix-index.enable = true;

  system.stateVersion = 4;
}
