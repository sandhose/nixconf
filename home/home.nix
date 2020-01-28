{ pkgs, ...}:

{
  sessionVariables = {
    EDITOR = "${pkgs.neovim}/bin/nvim";
    PAGER  = "${pkgs.less}/bin/less";
    LESS   = "-I -M -R --shift 5";
    PATH   = "$HOME/go/bin:$PATH";
  };
}
