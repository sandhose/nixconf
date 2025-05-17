{ ... }:

{
  virtualisation.docker = {
    enable = true;
    extraOptions = "--experimental";
  };

  # Enable BuildKit by default
  environment.etc."docker/daemon.json".text = builtins.toJSON { features.buildkit = true; };
}
