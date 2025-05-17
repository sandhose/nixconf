{ pkgs, ... }:

{
  imports = [ ./fonts.nix ];
  environment = {
    systemPackages = import ./packages.nix { inherit pkgs; };
  };

  nixpkgs.config = {
    allowBroken = false;
    allowUnsupportedSystem = false;
    allowUnfree = true;
  };

  programs = {
    gnupg = {
      agent = {
        enable = true;
        enableSSHSupport = false;
      };
    };
    zsh.enable = true;
  };
}
