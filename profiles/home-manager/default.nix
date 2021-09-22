{ ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    sharedModules = [ { home.stateVersion = "21.05"; } ];
  };
}
