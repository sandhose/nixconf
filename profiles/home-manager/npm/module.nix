{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.programs.npm;
  npmrcType =
    with types;
    attrsOf (oneOf [
      str
      bool
      path
      int
    ]);
in
{

  options = {
    programs.npm = {
      enable = mkEnableOption "NPM";

      package = mkOption {
        type = types.package;
        default = pkgs.nodejs;
        defaultText = literalExample "pkgs.nodejs";
        description = ''
          NPM package to install.
        '';
      };

      npmrc = {
        enable = mkEnableOption "Manage npmrc";
        # followXDG = mkOption {
        #   type = types.bool;
        #   default = false;
        # };
        path = mkOption {
          type = types.nullOr types.str;
          default = null;
        };
        injectEnv = mkOption {
          type = types.bool;
          default = true;
        };
        content = mkOption {
          type = npmrcType;
          internal = true;
          default = { };
        };
        file = mkOption {
          type = types.package;
          internal = true;
        };
      };

      prefix = mkOption {
        type = with types; nullOr str;
        default = null;
      };

      bin = mkOption { type = types.str; };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    { home.packages = [ cfg.package ]; }

    (mkIf (cfg.prefix != null) {
      programs.npm.npmrc.content.prefix = builtins.toPath "${config.home.homeDirectory}/${cfg.prefix}";
      programs.npm.bin = builtins.toPath "${config.home.homeDirectory}/${cfg.prefix}/bin";
      home.file."${cfg.prefix}/.keep".text = "";
    })

    (mkIf cfg.npmrc.enable {
      programs.npm.npmrc.file = pkgs.writeText "npmrc" (generators.toKeyValue { } cfg.npmrc.content);
    })

    # (mkIf (cfg.npmrc.enable && cfg.npmrc.followXDG) {
    #   xdg.configFile = {
    #     "npm/config".source = cfg.npmrc.file;
    #   };
    # })

    (mkIf (cfg.npmrc.enable && cfg.npmrc.injectEnv) {
      home.sessionVariables.NPM_CONFIG_USERCONFIG = cfg.npmrc.file;
      home.sessionVariables.NPM_BIN = cfg.bin;
    })
  ]);
}
