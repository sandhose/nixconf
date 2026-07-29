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
      postgresql_18
      postgresql_18.lib
      (lib.hiPrio postgresql_18.dev)
      postgresql_18.pg_config
      openssl
      openssl.dev
      pinentry_mac
      reattach-to-user-namespace
      cocoapods
      docker
      docker-compose
      docker-buildx
      docker-credential-helpers
      buildkit
      libssh
      pkg-config
      gettext
      zlib
      libiconv
      xcodegen
    ];

    variables = {
      EDITOR = "nvim";
      LANG = "en_US.UTF-8";
      PKG_CONFIG_PATH = "/run/current-system/sw/share/pkgconfig:/run/current-system/sw/lib/pkgconfig";
      #BUILDKIT_HOST = "podman-container://buildkitd";
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
}
