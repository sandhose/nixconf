{ pkgs }:

{
  systemPackages =
    with pkgs; [
      # bazel
      # openshift
      curl
      doctl
      docker-compose
      editorconfig-core-c
      # fly
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
      # mosquitto
      neovim
      nix-du
      nix-index
      nmap
      nodejs-14_x
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

      fig2dev
      fontconfig
      (texlive.combine {
        inherit (texlive)
          scheme-medium footmisc spreadtab xstring titlesec arydshln enumitem
          fvextra upquote chngcntr cleveref adjustbox collectbox tocbibind
          titling unamth-template bib-fr synttree wrapfig;
      })
      gnome3.librsvg

      # nodePackages.typescript-language-server
    ];
}
