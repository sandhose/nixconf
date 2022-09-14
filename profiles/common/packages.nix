{ pkgs }:

with pkgs; [
  # bazel
  cachix
  curl
  cloudflared
  # dnsutils
  doctl
  # docker-compose
  editorconfig-core-c
  # fly
  git
  git-lfs
  gnupg
  gnused
  gnutar
  #go-jsonnet # Broken on darwin as of 1/08/22
  graphviz
  htop
  imagemagick
  iperf
  isync
  jq
  kind
  kubectl
  kubernetes-helm
  # kubeseal
  kustomize
  #kpt # Broken on darwin as of 1/08/22
  mosh
  nix-index
  nmap
  nodejs_latest
  openssl
  openssl.dev
  pandoc
  parallel
  # pgcli
  pkg-config
  # protobuf
  # poetry # Installed via pipx instead
  python3Packages.pipx
  pwgen
  # python
  # python3
  python3Full
  # python37Packages.ansible
  redis
  # rustup
  my.s3cmd
  # socat
  sqlite-interactive
  sshpass
  terraform_1
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
  # clang-tools # broken on darwin

  # elixir
  # fig2dev
  fontconfig
  (texlive.combine {
    inherit (texlive)
      scheme-medium footmisc spreadtab xstring titlesec arydshln enumitem
      fvextra upquote chngcntr cleveref adjustbox collectbox tocbibind titling
      unamth-template bib-fr synttree wrapfig lastpage ifmtarg numprint bophook;
  })
  # gnome3.librsvg

  # maven
  # argocd
  # autoconf
  # autogen
  # automake
  bazel-buildtools
  # bazel-watcher
  bazelisk
  cargo-bloat
  cargo-edit
  cloc
  # cmake
  dos2unix
  ffmpeg
  fluxcd
  gawk
  gitAndTools.gh
  go
  # inkscape
  # jabref
  # keybase # Broken on darwin as of 1/08/22
  kind
  librsvg
  # buildpack
  shellcheck
  sops
  # weechat
  xmlsec
  xz
  yarn
  jdk11

  gnumake
  go
  #lldb
  file

  sqlx-cli
  mdbook
  minio-client
  less

  consul
  nomad

  # Needed by Telescope.nvim
  fd
  bat
  ripgrep

  (fenix.combine [
    fenix.latest.rustfmt

    fenix.stable.llvm-tools-preview
    fenix.stable.clippy
    fenix.stable.cargo
    fenix.stable.rust-src
    fenix.stable.rust-std
    fenix.stable.rustc
    fenix.targets.wasm32-unknown-unknown.stable.rust-std
  ])
]
