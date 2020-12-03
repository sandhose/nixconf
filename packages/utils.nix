{ writeShellScriptBin, pkgs, ... }:

writeShellScriptBin "kubestate" ''
  ${pkgs.kubectl}/bin/kubectl config view -o json --minify \
    | ${pkgs.jq}/bin/jq -r '
        . as $root
        | .contexts[]
        | select(.name == $root["current-context"])
        | .name + "/" + (.context.namespace // "default")
    '
''
