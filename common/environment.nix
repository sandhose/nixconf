{ pkgs }:

{
  systemPackages =
    with pkgs; [
      bazel
      curl
      doctl
      editorconfig-core-c
      fly
      git
      git-lfs
      gnupg
      gnused
      gnutar
      go-jsonnet
      graphviz
      htop
      imagemagick
      iperf
      isync
      jq
      kubectl
      kubernetes-helm
      kubeseal
      kustomize
      mosh
      mosquitto
      neovim
      nix-du
      nmap
      nodejs
      pandoc
      parallel
      pgcli
      protobuf
      pwgen
      python
      python3
      python37Packages.ansible
      redis
      socat
      sqlite
      sshpass
      terraform
      tmux
      unixtools.watch
      unrar
      urlview
      vim
      w3m
      watchman
      wget
      wrk
      youtube-dl
      yq
      zsh-funcs
    ];
}
