---
title: Staging environment
layout: "base.njk"
eleventyNavigation:
  key: Providers
  title: Staging environment
  parent: Servers
  order: 5
---

Staging environments are a good protection against bad things happening to your production server.

## 1. Declare staging server in flake.nix

You can define staging and production environments in the same Nix flake.

In your `flake.nix`, you will find a place where NixOS configurations are defined.

```nix
{
  nixosConfigurations."my-app" = nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = attrs // {
      environment = "production";
    };
    modules = [
      # Overlays-module makes "pkgs.unstable" available in configuration.nix
      ({ config, pkgs, ... }: {
        nixpkgs.overlays = [ overlay-unstable ];
      })
      ./nixos/configuration.nix
    ];
  };
}
```

You can simply clone it and change the hostname (from "my-app" to "my-app-stage"). Also change the `environment` value into for example `"stage"`.

```nix
{
  nixosConfigurations."my-app" = nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = attrs // {
      environment = "production";
    };
    modules = [
      ({ config, pkgs, ... }: {
        nixpkgs.overlays = [ overlay-unstable ];
      })
      ./nixos/configuration.nix
    ];
  };
+ nixosConfigurations."my-app-stage" = nixpkgs.lib.nixosSystem {
+   inherit system;
+   specialArgs = attrs // {
+     environment = "stage";
+   };
+   modules = [
+     ({ config, pkgs, ... }: {
+       nixpkgs.overlays = [ overlay-unstable ];
+     })
+     ./nixos/configuration.nix
+   ];
+ };
}
```

## Create the staging server from ship-nix

When creating a new server, select the "Migrate" option.

After the server is provisioned, select the server preset that aligns with your running server and choose the `Import a project already compatible with ship-nix`.

Follow the instructions to add your repo.

<div class="bg-blue-100 rounded-lg py-5 px-6 mb-4 text-base text-blue-700 mb-3" role="alert">
  Remember to check if the environment variables are correct before deploying!
</div>

Then click deploy. If your project is properly configured to provision the server, you should be running a clone of your production server in terms of configuration.
