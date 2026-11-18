{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.programs.rex;
in
{
  programs.rex = {
    enable = true;
    # The flake has no package for x86_64-darwin.
    package = inputs.rex.packages.${pkgs.stdenv.hostPlatform.system}.rex or null;
    config = ./init.lua;
    # ~/.ssh/config is not managed by home-manager; profiles/darwin installs
    # the guard system-wide.
    sshGuard = false;
  };

  home.packages = [
    # Ghostty's default font, which it embeds; Rex needs it installed.
    pkgs.jetbrains-mono
  ]
  ++ lib.optional (cfg.package != null) (
    pkgs.runCommand "rex-zsh-completion" { } ''
      mkdir -p $out/share/zsh/site-functions
      HOME=$TMPDIR ${lib.getExe cfg.package} completion zsh > $out/share/zsh/site-functions/_rex
    ''
  );

  # nix-darwin resets PATH at shell start, which drops the directory of the
  # rex binary matching the running server that Rex prepends.
  programs.zsh.initContent = ''
    if [ -n "$REX_BIN_DIR" ]; then
      export PATH="$REX_BIN_DIR:$PATH"
    fi
  '';
}
