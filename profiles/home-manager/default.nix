{ inputs, ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    sharedModules = [
      { home.stateVersion = "22.05"; }
      inputs.rex.homeManagerModules.default
    ];
  };
}
