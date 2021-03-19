{ pkgs, ... }:

{
  imports = [ ./fonts.nix ];
  environment = { systemPackages = import ./packages.nix { inherit pkgs; }; };

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
}
