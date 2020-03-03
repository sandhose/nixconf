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

  fonts.fonts = with pkgs; [
    fira-code
    roboto
  ];
}
