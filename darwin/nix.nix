{ pkgs } :

{
  trustedUsers = [ "@admin" ];

  binaryCaches = [ "https://cache.nixos.org/" "s3://nix?endpoint=s3.sandhose.fr" ];
  binaryCachePublicKeys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" "sandhose-nix-cache-1:jOYK6USDbZthJxkxMAV8rybnah63ujWqBZzio2sfEhY=" ];

  useSandbox = false;
  sandboxPaths = [ "/System/Library/Frameworks" "/System/Library/PrivateFrameworks" "/usr/lib" "/private/tmp" "/private/var/tmp" "/usr/bin/env" ];
  package = pkgs.nix;

  maxJobs = 3;
  buildCores = 3;
}
