{
  nix-index.enable = true;
  gnupg = {
    agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
  # tmux = import ./tmux.nix;
  zsh.enable = true;
}
