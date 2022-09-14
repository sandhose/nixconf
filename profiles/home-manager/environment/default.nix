{ pkgs, ... }:

{
  home.sessionVariables = {
    EDITOR = "nvim";
    PAGER = "less";
    LESS = "-I -M -R --shift 5";
    PATH = "$HOME/.local/bin:$PATH";
    GIT_SSL_CAINFO = "/run/current-system/etc/ssl/certs/ca-certificates.crt";
  };
}
