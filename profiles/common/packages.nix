{ pkgs }:

with pkgs;
[
  acli
  bat
  cachix
  caddy
  cargo-deny
  cargo-edit
  cloc
  cloudflared
  cmake
  cosign
  curl
  fd
  ffmpeg
  file
  fluxcd
  gawk
  gh
  gh-stack
  git
  git-absorb
  git-lfs
  glab
  gnupg
  gnused
  gnutar
  go
  go-jsonnet
  google-cloud-sdk
  grafana-loki
  graphviz
  htop
  imagemagick
  iperf
  jq
  jsonnet-bundler
  just
  k3d
  kind
  kubectl
  kubectl-cnpg
  kubelogin-oidc
  kubernetes-helm
  kustomize
  less
  libffi.dev
  mailpit
  mdbook
  my.zsh-funcs
  nix-index
  nodejs_24
  openssl
  openssl.dev
  opentofu
  overmind
  pandoc
  parallel
  pkg-config
  prometheus
  protobuf
  pwgen
  redis
  ripgrep
  rustup
  shellcheck
  sops
  sqlite-interactive
  sqlx-cli
  unixtools.watch
  uv
  vault-bin
  vim
  wget
  wrk
  xz
  yq
  yt-dlp

  (lib.hiPrio corepack)

  # elixir
  # fig2dev
  fontconfig
  #(texlive.combine {
  #  inherit (texlive)
  #    scheme-medium
  #    footmisc
  #    spreadtab
  #    xstring
  #    titlesec
  #    arydshln
  #    enumitem
  #    fvextra
  #    upquote
  #    chngcntr
  #    cleveref
  #    adjustbox
  #    collectbox
  #    tocbibind
  #    titling
  #    unamth-template
  #    bib-fr
  #    synttree
  #    wrapfig
  #    lastpage
  #    ifmtarg
  #    numprint
  #    bophook
  #    beamertheme-metropolis
  #    ucs
  #    csvsimple
  #    environ
  #    svg
  #    transparent
  #    multirow
  #    ;
  #  inherit auto-multiple-choice;
  #})
  #auto-multiple-choice
  # gnome.librsvg
]
