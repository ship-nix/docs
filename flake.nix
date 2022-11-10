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
          projectName = "ship-nix-docs";
          pkgs = nixpkgs.legacyPackages.${system};
          buildPackage = pkgs.callPackage nix-npm-buildpackage { };
          nodeDependencies = buildPackage.mkNodeModules {
            src = ./.;
            pname = "npm";
            version = "8";
          };
          # If you want the node_modules folder to be visible as a symlink for debugging
          # It should generally be off when installing packages as it can confuse npm
          show_node_modules = false;
        in
        {
          defaultPackage = pkgs.stdenv.mkDerivation
            {
              name = projectName + "-build";
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
                cp -r src/images/. $out/images
              '';
            };
          devShell = pkgs.mkShell
            (
              {
                name = projectName + "-shell";
                buildPhase = "";
                buildInputs = [ pkgs.esbuild pkgs.nodejs ];
                src = ./.;
                shellHook = '' 
                      export NODE_ENV=development
                      export NODE_PATH=${nodeDependencies}/node_modules
                      rm -f node_modules
                      ${if show_node_modules then "ln -s $NODE_PATH node_modules" else ""}
                      export npm_config_cache=~/.npm
                      echo "Welcome to your nix development shell"
                      echo "Run 'npm run start' to run dev server"
                    '';
              }
            );
        }
      );
}
