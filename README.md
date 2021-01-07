This is my personal [nix](https://nixos.org/) configuration.

# Notes on setuping a NixOS host from scratch

- Boot from the [latest unstable ISO](https://nixos.org/channels/nixos-unstable)
- Format the disks (see [hosts/sandhose-desktop](./hosts/sandhose-desktop/default.nix))
- Mount the disks under `/mnt`
- Run as root a new nix shell with `nixUnstable` and `cachix`:
  ```sh
  nix-shell -p nixUnstable -p cachix
  ```
- Enable the cachix cache:
  `cachix use sandhose -m user-nixconf`
- Enable unstable features:
  ```sh
  echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
  ```
- Install the system (`--impure` seems necessary):
  ```sh
  nixos-install --flake 'github:sandhose/nixconf#sandhose-desktop' --root /mnt --impure
  ```
