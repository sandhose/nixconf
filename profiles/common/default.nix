{ pkgs, ... }:

{
  imports = [ ./fonts.nix ];
  environment = { systemPackages = import ./packages.nix { inherit pkgs; }; };

  nixpkgs.config = {
    allowBroken = true;
    allowUnsupportedSystem = true;
    allowUnfree = true;
    permittedInsecurePackages = [ "electron-9.4.4" ];
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
