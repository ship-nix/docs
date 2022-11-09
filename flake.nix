{
  inputs =
    {
      flake-utils = { url = "github:numtide/flake-utils"; };
      nix-npm-buildpackage = { url = "github:serokell/nix-npm-buildpackage"; };
    };

  outputs =
    { self, flake-utils, nix-npm-buildpackage, nixpkgs }:
    flake-utils.lib.eachDefaultSystem
      (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          buildPackage = pkgs.callPackage nix-npm-buildpackage { };
          nodeDependencies = buildPackage.mkNodeModules {
            src = ./.;
            pname = "npm";
            version = "8";
          };
        in
        {
          defaultPackage = pkgs.stdenv.mkDerivation
            (
              {
                name = "nodeserver-pkg";
                buildInputs = [ pkgs.nodejs ];
                src = ./.;
                installPhase = ''
                  export NODE_ENV=production
                  export NODE_PATH=${nodeDependencies}/node_modules
                  export npm_config_cache=${nodeDependencies}/config-cache
                  mkdir $out
                  ${nodeDependencies}/node_modules/@11ty/eleventy/cmd.js --output $out
                '';
              }
            );
          devShell = pkgs.mkShell
            (
              {
                name = "nodeserver-shell";
                buildPhase = "";
                buildInputs = [ pkgs.esbuild pkgs.nodejs ];
                src = ./.;
                shellHook = '' 
                      export NODE_ENV=development
                      export NODE_PATH=${nodeDependencies}/node_modules
                      export npm_config_cache=~/.npm
                      echo "Welcome to your nix development shell"
                      echo "Run 'npm run watch' to run dev server"
                    '';
              }
            );
        }
      );
}
