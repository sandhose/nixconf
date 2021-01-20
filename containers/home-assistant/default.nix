{ config, inputs, ... }:

{
  imports = [ inputs.sops-nix.nixosModules.sops ../base ];

  networking.hostName = "home-assistant";

  services.home-assistant = {
    enable = true;
    openFirewall = true;

    config = {
      homeassistant = {
        name = "Home";
        latitude = "!secret latitude";
        longitude = "!secret longitude";
        elevation = "!secret elevation";
        unit_system = "metric";
        time_zone = "Europe/Paris";
      };

      default_config = { };
    };
  };

  # Give `hass` access to the secrets
  users.users.hass.extraGroups = [ config.users.groups.keys.name ];

  # TODO: share this with the host?
  sops.gnupgHome = "/var/lib/sops";
  sops.defaultSopsFile = ./secrets.yaml;
  sops.secrets."home-assistant-secrets.yaml" = {
    owner = "hass";
    path = "/var/lib/hass/secrets.yaml";
  };
}
