{ pkgs, config, lib, inputs, ... }:

{
  imports = [
    ./cachix.nix
    ../home
  ];

  nixpkgs.overlays = [ inputs.self.overlay ];
  nix.registry.nixpkgs.flake = inputs.nixpkgs;

  environment = {
    systemPackages = import ./packages.nix { inherit pkgs; };
  };

  nixpkgs.config = {
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
      corefonts
      # liberation_ttf_v2
      merriweather
      opensans-ttf
      raleway
      cascadia-code
      my.fork-awesome
      my.virgil
    ];
  };
}
