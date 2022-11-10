{ pkgs ? import <nixpkgs> { }
, nodeDependencies ? (buildPackage.mkNodeModules {
    src = ./.;
    pname = "npm";
    version = "8";
  })
, ...
}:
pkgs.stdenv.mkDerivation
  (
    {
      name = "documentation-build";
      buildInputs = [ pkgs.esbuild pkgs.nodejs ];
      src = ./.;
      installPhase = ''
        export NODE_ENV=production
        export NODE_PATH=${nodeDependencies}/node_modules
        export npm_config_cache=${nodeDependencies}/config-cache
        mkdir $out
        ${nodeDependencies}/node_modules/@11ty/eleventy/cmd.js --output $out
        $src/bin/tailwindcss-linux-x64 -i $src/src/index.css -o $out/app.css --minify
        ${pkgs.esbuild}/bin/esbuild $src/src/index.js --bundle --outfile=$out/app.js
      '';
    }
