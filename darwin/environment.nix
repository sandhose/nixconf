{ pkgs }:

{
  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  systemPackages =
    with pkgs; [
      zsh-funcs

      curl
      htop
      jq
      vim
      neovim
      vagrant
      terraform
      pwgen
      postgresql_12
      pinentry_mac
      weechat
      tmux

      scons
      # gcc-arm-embedded
      nnn
      nats-streaming-server
      sshpass
      nix-du
      fly
      kubeseal
      libcoap
      python37Packages.onkyo-eiscp

      doctl
      git
      git-lfs
      graphviz
      python
      python3
      iperf
      isync
      gradle
      maven
      kubectl
      kubernetes-helm
      kustomize
      mosh
      mosquitto
      nodejs
      notmuch
      pandoc
      parallel
      pgcli
      reattach-to-user-namespace
      socat
      unrar
      urlview
      w3m
      unixtools.watch
      watchman
      wget
      youtube-dl
      yq
      neomutt
      rustup
      # haskellPackages.pandoc-citeproc
      # haskellPackages.pandoc-crossref
      wrk
      go-jsonnet
      gnused
      gnutar
      protobuf
      luajit
      redis
      sqlite
      editorconfig-core-c
      # mysql-client
      imagemagick
      msmtp
      gnupg

      # xquartz
      # wireshark
    ];

  variables = {
    EDITOR = "${pkgs.neovim}/bin/nvim";
    LANG = "en_US.UTF-8";
  };
}
