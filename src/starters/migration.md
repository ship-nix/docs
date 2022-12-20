---
title: Load existing code on a new server
layout: "base.njk"
eleventyNavigation:
  key: Migration
  title: Load existing code
  parent: Starters
  order: 1
---

The `Load existing code on a new server` option is for when you already have code you wish to ship on {{site.name}}.

There are two supported use-cases.

## 1. Import a project that already works with {{site.name}}

After provisioning the server, do the following:

1. In your code, make sure you have a NixOS configuration that corresponds with your server name given by {{site.name}}.

<img src="/images/server-name.webp" />

```diff-nix
{
  description = "NixOS configuration";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
  };
  outputs =
    { self
    , nixpkgs
    , nixpkgs-unstable
    } @attrs:
    let
      ...
    in
    {
      nixosConfigurations."test-server-one" = nixpkgs.lib.nixosSystem {
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
+     nixosConfigurations."test-server-two" = nixpkgs.lib.nixosSystem {
+       inherit system;
+       specialArgs = attrs // {
+         environment = "stage";
+       };
+       modules = [
+         # Overlays-module makes "pkgs.unstable" available in configuration.nix
+         ({ config, pkgs, ... }: {
+           nixpkgs.overlays = [ overlay-unstable ];
+         })
+         ./nixos/configuration.nix
+       ];
+     };
+   };

}

```

2. **Select your preset** so {{site.name}} can make as good preparations as possible for provisioning (binary caches, databases etc)
   <img src="/images/select-preset.webp" />
3. Follow the guide to add Git and deploy keys
4. Check your environment variables and make sure they are correct
   <img src="/images/environment-view.webp" />
5. Deploy
   <img src="/images/deploy-btn-migrate.webp" />

If something went wrong, just adjust accordingly and try again.

## 2. Shipnixify a project without {{site.name}} config

You can turn a non-{{site.name}} project into a {{site.name}} project with a bit of additional work.

After provisioning the server, do the following:

1. **Select your preset** so {{site.name}} can make as good preparations as possible for provisioning (binary caches, databases etc)
   <img src="/images/select-preset.webp" />
2. Click `Generate shipnixifier`
   <img src="/images/generate-shipnixifier.webp" />
3. Follow the instruction on your local machine to add the generated {{site.name}} config
   <img src="/images/shipnixifier-script.webp" />
4. Follow the guide to add Git and deploy keys
5. Check your environment variables and make sure they are correct
   <img src="/images/environment-view.webp" />
6. Deploy
   <img src="/images/deploy-btn-migrate.webp" />
