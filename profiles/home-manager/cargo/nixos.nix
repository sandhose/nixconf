{ pkgs, ... }:

{
  home.file.".cargo/config.toml".text = ''
    [build]
    rustflags = ["-C", "link-arg=-fuse-ld=lld"]
  '';
}
