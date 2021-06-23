{ pkgs }:

with pkgs; [
  # bazel
  my.cachix
  curl
  dnsutils
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
  kind
  kubectl
  kubernetes-helm
  kubeseal
  kustomize
  mosh
  neovim
  nix-index
  nmap
  nodejs_latest
  pandoc
  parallel
  # pgcli
  protobuf
  pwgen
  # python
  # python3
  python39Full
  # python37Packages.ansible
  redis
  # rustup
  socat
  sqlite
  sshpass
  terraform_0_14
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

  # elixir
  # fig2dev
  fontconfig
  (
    texlive.combine {
      inherit (texlive)
        scheme-medium footmisc spreadtab xstring titlesec arydshln enumitem
        fvextra upquote chngcntr cleveref adjustbox collectbox tocbibind titling
        unamth-template bib-fr synttree wrapfig lastpage
        ;
    }
  )
  gnome3.librsvg

  maven
  # argocd
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
  fluxcd
  gawk
  gitAndTools.gh
  go
  # inkscape
  # jabref
  keybase
  kind
  librsvg
  buildpack
  shellcheck
  sops
  # weechat
  xmlsec
  xz
  yarn

  gnumake
  go
  lldb
  file

  # Needed by Telescope.nvim
  fd
  bat
  ripgrep

  (
    with fenix; combine (
      with stable; [
        cargo
        clippy-preview
        rust-std
        rustc
        rustfmt-preview
        rust-src
      ]
    )
  )
]
