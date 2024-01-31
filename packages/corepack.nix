{ stdenv, nodejs_20, ... }:

stdenv.mkDerivation rec {
  name = "corepack";
  dontBuild = true;
  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    #ln -s ${nodejs_20}/lib/node_modules/corepack/dist/npm.js $out/bin/npm
    #ln -s ${nodejs_20}/lib/node_modules/corepack/dist/npx.js $out/bin/npx
    ln -s ${nodejs_20}/lib/node_modules/corepack/dist/pnpm.js $out/bin/pnpm
    ln -s ${nodejs_20}/lib/node_modules/corepack/dist/pnpx.js $out/bin/pnpx
    ln -s ${nodejs_20}/lib/node_modules/corepack/dist/yarn.js $out/bin/yarn
    ln -s ${nodejs_20}/lib/node_modules/corepack/dist/yarnpkg.js $out/bin/yarnpkg
  '';
}
