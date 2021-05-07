{ ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    sharedModules = [ { home.stateVersion = "20.09"; } ];
  };
}
