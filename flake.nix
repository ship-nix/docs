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
          # If you want the node_modules folder to be visible as a symlink for debugging
          # It should generally be off when installing packages as it can confuse npm
          show_node_modules = false;
        in
        {
          defaultPackage = (pkgs.callPackage ./default.nix { });
          devShell = pkgs.mkShell
            (
              {
                name = "documentation-shell";
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
