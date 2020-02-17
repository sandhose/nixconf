{ pkgs, config, ...}:

{
  sessionVariables = {
    EDITOR = "${pkgs.neovim}/bin/nvim";
    PAGER  = "${pkgs.less}/bin/less";
    LESS   = "-I -M -R --shift 5";
    PATH   = "$NPM_BIN:$HOME/go/bin:$PATH";
  };
}
