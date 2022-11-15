---
title: Package Management
layout: "base.njk"
eleventyNavigation:
  key: PackageManagement
  title: Package Management
  parent: Servers
  order: 6
---

Being built on the Nix package manager, NixOS has many entrypoints to the package registry that make it unique compared to most Linux distributions.

- [NixOS package search](https://search.nixos.org/packages)
- [How Nix works](https://nixos.org/guides/how-nix-works.html)
- [Nix package manager manual](https://nixos.org/manual/nix/unstable/introduction.html)

## Command-line via your server

When you are entering your server via SSH, there are a couple of couple of ways to interact with packages.

### 1. Install package in temporary shell

Sometimes, you just want to test a package on your NixOS machine, but not install it permanently.

Let's say you want to test neovim, but not sure if you should install it on your server.

```bash
nix-shell -p neovim
```

Now you can play with neovim in a temporary Nix shell. Neovim will be gone after closing the shell.

Great for when you want to explore new tools without having to install and uninstall.

### 2. Install as if it was homebrew/apt-get (not recommended)

```bash
nix-env -iA nixos.neovim
```

You usually want to avoid this when working with NixOS servers.

## NixOS configuration

Declarative NixOS configurations are the way to for installing a package globally on your server.

Your `configuration.nix` will likely contain something like this:

```nix
environment.systemPackages = [
  pkgs.bash
  ];
```

If you have decided you want to install neovim on your server permanently, you can add it in the list (no comma).

```nix
environment.systemPackages = [
    pkgs.bash
    pkgs.neovim
  ];
```

## Use unstable packages

All {{site.name}} starters has the ability to also use unstable packages by using the `unstable`-prefix.

```nix
environment.systemPackages = [
  pkgs.bash
  unstable.neovim
  ];
```

## Enable unfree packages

You should see this in your :

Simply uncomment and comment out the line above which you will find on `flake.nix`:

```diff-nix

    let
      system = "x86_64-linux";
      overlay-unstable = final: prev: {
-       # unstable = nixpkgs-unstable.legacyPackages.${prev.system};
-       # use this variant if unfree packages are needed:
+        unstable = import nixpkgs-unstable {
+        inherit system;
+       config.allowUnfree = true;
+      };
    in {
```
