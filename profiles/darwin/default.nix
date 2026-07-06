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

  # nix-darwin's darwin-manual-html build calls `nixos-render-docs manual html
  # --toc-depth`, which newer nixpkgs' nixos-render-docs removed in favour of
  # --sidebar-depth (see nix-darwin PRs #1818/#1819). Skip building the HTML
  # manual + `darwin-help` until that fix lands upstream; manpages still work.
  # The uninstaller embeds its own darwin-system with docs on, so it drags the
  # broken manual back into the closure — disable it too.
  documentation.doc.enable = false;
  system.tools.darwin-uninstaller.enable = false;

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
      #podman
      #podman-compose
      buildkit
      libssh
      pkg-config
      gettext
      zlib
      libiconv
      llvmPackages.openmp
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
