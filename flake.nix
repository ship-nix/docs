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
          projectName = "shipnix-docs";
          pkgs = nixpkgs.legacyPackages.${system};
          buildPackage = pkgs.callPackage nix-npm-buildpackage { };
          nodeDependencies = buildPackage.mkNodeModules {
            src = ./.;
            pname = "npm";
            version = "8";
          };
          # If you want the node_modules folder to be visible as a symlink for debugging
          # It should generally be off when installing packages as it can confuse npm
          show_node_modules = true;
        in
        {
          defaultPackage = pkgs.stdenv.mkDerivation
            {
              name = projectName + "-build";
              buildInputs = [ pkgs.esbuild pkgs.nodejs pkgs.graphicsmagick ];
              src = ./.;
              installPhase = ''
                set -xe
                export NODE_ENV=production
                export NODE_PATH=${nodeDependencies}/node_modules
                export npm_config_cache=${nodeDependencies}/config-cache
                mkdir $out
                ${nodeDependencies}/node_modules/@11ty/eleventy/cmd.js --output $out
                $src/bin/tailwindcss-linux-x64 -i $src/src/index.css -o $out/app.css --minify
                ${pkgs.esbuild}/bin/esbuild $src/src/index.js --bundle --outfile=$out/app.js
                mkdir -p $out/images
                cp $src/src/images/*.svg $out/images/
                cp $src/assets/* $out/
  
                for file in $src/src/images/*.jpg
                do
                  outfile=`basename $file .jpg`.webp
                  echo convert -verbose -resize 1400x1200\> -quality 80 "'$file'" \
                  +profile "'*'" "'$out/images/$outfile'"
                done | gm batch -echo on -feedback on - && \
                for file in $src/src/images/*.png
                do
                  outfile=`basename $file .png`.webp
                  echo convert -verbose -resize 1400x1200\> -quality 80 "'$file'" \
                  +profile "'*'" "'$out/images/$outfile'"
                done | gm batch -echo on -feedback on -
              '';
            };
          devShell = pkgs.mkShell
            (
              {
                name = projectName + "-shell";
                buildPhase = "";
                buildInputs = [ pkgs.esbuild pkgs.nodejs pkgs.graphicsmagick ];
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
