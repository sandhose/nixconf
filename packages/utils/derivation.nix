{ writeShellScriptBin, jq, kubectl, stdenv, ... }:

writeShellScriptBin "kubestate" ''
  ${kubectl}/bin/kubectl config view -o json --minify \
    | ${jq}/bin/jq -r '
        . as $root
        | .contexts[]
        | select(.name == $root["current-context"])
        | .name + "/" + (.context.namespace // "default")
    '
''
