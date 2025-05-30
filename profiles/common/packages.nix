{ pkgs }:

with pkgs;
[
  # bazel
  cachix
  caddy
  curl
  #cloudflared
  cosign
  deno
  # dnsutils
  doctl
  # docker-compose
  editorconfig-core-c
  # fly
  git
  git-lfs
  git-absorb
  gnupg
  gnused
  gnutar
  #go-jsonnet # Broken on darwin as of 1/08/22
  graphviz
  htop
  imagemagick
  iperf
  isync
  icu.dev
  jq
  just
  jsonnet
  jsonnet-bundler
  jsonnet-language-server
  kind
  kubectl
  kubelogin-oidc
  kubernetes-helm
  # kubeseal
  kustomize
  #kpt # Broken on darwin as of 1/08/22
  #mosh
  nix-index
  nixd
  nmap
  nodejs_20
  openssl
  openssl.dev
  overmind
  pandoc
  parallel
  # pgcli
  pkg-config
  protobuf
  # poetry # Installed via pipx instead
  # python3Packages.pipx
  pwgen
  # python
  # python3
  # python3Full
  # python37Packages.ansible
  redis
  rye
  rustup
  # socat
  sqlite-interactive
  sshpass
  terraform_1
  tmux
  unixtools.watch
  unrar
  #urlview
  uv
  vim
  w3m
  # watchman # 4+ years old, installed manually instead
  wget
  wrk
  yt-dlp
  yq
  my.zsh-funcs
  # clang-tools # broken on darwin
  #zig

  haproxy
  python3Packages.supervisor
  prometheus

  (hiPrio corepack_22)
  (hiPrio fenix.rust-analyzer)

  # elixir
  # fig2dev
  fontconfig
  #(texlive.combine {
  #  inherit (texlive)
  #    scheme-medium footmisc spreadtab xstring titlesec arydshln enumitem
  #    fvextra upquote chngcntr cleveref adjustbox collectbox tocbibind titling
  #    unamth-template bib-fr synttree wrapfig lastpage ifmtarg numprint bophook
  #    beamertheme-metropolis;
  #})
  # gnome.librsvg

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
  # cargo-expand
  cargo-deny
  cargo-machete
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
  # keybase # Broken on darwin as of 1/08/22
  kind
  librsvg
  libffi.dev
  # buildpack
  shellcheck
  sops
  # weechat
  xmlsec
  xz
  jdk11

  gnumake
  go
  file

  sqlx-cli
  mdbook
  minio-client
  less

  consul
  nomad
  packer
  vault-bin

  # Needed by Telescope.nvim
  fd
  bat
  ripgrep

  #(fenix.complete.withComponents [ "rustc" "rustfmt" ])
  #(hiPrio
  #  (fenix.combine [
  #    fenix.stable.llvm-tools-preview
  #    fenix.stable.clippy
  #    fenix.stable.cargo
  #    fenix.stable.rust-src
  #    fenix.stable.rust-std
  #    fenix.stable.rustc
  #    fenix.targets.wasm32-unknown-unknown.stable.rust-std
  #    fenix.targets.x86_64-unknown-linux-musl.stable.rust-std
  #    fenix.targets.aarch64-unknown-linux-musl.stable.rust-std
  #    fenix.targets.x86_64-unknown-linux-gnu.stable.rust-std
  #    fenix.targets.aarch64-unknown-linux-gnu.stable.rust-std
  #    fenix.targets.x86_64-apple-darwin.stable.rust-std
  #    fenix.targets.aarch64-apple-darwin.stable.rust-std
  #    fenix.targets.aarch64-apple-ios.stable.rust-std
  #    fenix.targets.aarch64-apple-ios-sim.stable.rust-std
  #    fenix.targets.x86_64-pc-windows-msvc.stable.rust-std
  #    fenix.targets.aarch64-pc-windows-msvc.stable.rust-std
  #    fenix.targets.riscv32imac-unknown-none-elf.stable.rust-std
  #  ]))
]
