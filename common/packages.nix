{ pkgs }:

with pkgs; [
  # bazel
  cachix
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
  neovim
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
  rustup
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
  my.zsh-funcs
  clang-tools

  elixir
  fig2dev
  fontconfig
  (texlive.combine {
    inherit (texlive)
      scheme-medium footmisc spreadtab xstring titlesec arydshln enumitem
      fvextra upquote chngcntr cleveref adjustbox collectbox tocbibind
      titling unamth-template bib-fr synttree wrapfig;
  })
  gnome3.librsvg

  maven
  argocd
  autoconf
  autogen
  automake
  bazel-buildtools
  # bazel-watcher
  bazelisk
  cargo-bloat
  cargo-edit
  cloc
  cmake
  dos2unix
  ffmpeg
  fluxctl
  gawk
  gitAndTools.gh
  go
  inkscape
  # jabref
  keybase
  kind
  librsvg
  libtool
  buildpack
  shellcheck
  sops
  weechat
  xmlsec
  xz
  yarn
]
