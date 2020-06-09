{ pkgs, config, system, ... }:

{
  imports = [
    ../home
  ];

  environment = import ./environment.nix { inherit pkgs; };

  nixpkgs.config = {
    packageOverrides = pkgs: {
      zsh-funcs = pkgs.callPackage ../packages/zsh-funcs { };
    };

    allowBroken = true;
    allowUnsupportedSystem = true;
    allowUnfree = true;
  };

  programs = {
    gnupg = {
      agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };
    zsh.enable = true;
  };

  fonts = {
    enableFontDir = true;
    fonts = with pkgs; [
      fira-code
      roboto
      roboto-mono
      roboto-slab
      source-sans-pro
      source-code-pro
      source-serif-pro
      ibm-plex
      liberation_ttf_v2
      merriweather
      opensans-ttf
      raleway
    ];
  };
}
