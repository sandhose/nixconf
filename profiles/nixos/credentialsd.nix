{ inputs, ... }:

# Passkeys / WebAuthn through credentialsd and the experimental Credential
# portal. Uses the unofficial flake until credentialsd and a portal release
# with the Credential interface land in nixpkgs.
{
  imports = [ inputs.credentialsd.nixosModules.default ];

  # Daemon, UI, D-Bus/systemd user services and the patched xdg-desktop-portal
  services.credentialsd.enable = true;

  # Firefox is managed through home-manager: this registers the native
  # messaging host and installs the signed helper add-on
  home-manager.users.sandhose = {
    imports = [ inputs.credentialsd.homeModules.default ];
    programs.credentialsd.enable = true;
  };
}
