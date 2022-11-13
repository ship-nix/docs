---
title: Anatomy of a ship-nix project
layout: "base.njk"
eleventyNavigation:
  key: Anatomy
  title: Anatomy of a ship-nix project
  parent: Servers
  order: 9
---

You can turn your ship-nix server into virtually anything you want. But there are some conventions for your project to work with ship-nix.

It's not supported nor recommended to build this file structure manually. This article is mainly for extra transparency of how ship-nix works.

You can read about making your project ship-nix compatible in the [migration guide](./migrate-project-to-shipnix.md) of this section.

## Required files and folders

First of all, ship-nix requires a `nixos` folder at the root of your project repository.

A ship-nix compatible projects folder must at minimum have these files:

```
.
├── flake.nix
└── nixos/
    ├── authorized_keys
    ├── configuration.nix
    ├── scripts/
    │   ├── after-rebuild
    │   ├── before-rebuild
    │   └── provision
    └── ship.nix
```

### authorized_keys

A convention is to have `authorized_keys` file inside the repository. This file contains SSH public keys and controls who has SSH access to the server.

The default [ship.nix](#shipnix) file depends on this file at this specific location through this configuration.

```nix
  users.users.ship = {
    isNormalUser = true;
    extraGroups = [ "wheel" "nginx" ];
    openssh.authorizedKeys.keyFiles = [ ./authorized_keys ];
  };
```

### configuration.nix

This is the entry point to where you configure your system

- [Read more about configuration in NixOS manual](https://NixOS.org/manual/NixOS/stable/)

### flake.nix

Nix flakes is an experimental feature of the Nix package manger, but ship-nix has build around flakes because we believe it's a vital part of the future of Nix.

Here is a decent definition:

> A flake is simply a source tree (such as a Git repository) containing a file named flake.nix that provides a standardized interface to Nix artifacts such as packages or NixOS modules. Flakes can have dependencies on other flakes, with a “lock file” pinning those dependencies to exact revisions to ensure reproducible evaluation.
>
> > From [An introduction to Nix Flakes](https://www.tweag.io/blog/2020-05-25-flakes/) (tweag.io)

With a flake, you can declare your whole Nix configuration in your project repo and easily build it on your ship-nix server.

- [Read about Nix flakes on NixOS wiki](https://NixOS.wiki/wiki/Flakes)

### scripts/

Your ship-nix configuration must contain an executable **after-rebuild, before-rebuild and provision** script even if you don't wish to perform any actions in these lifecycle stages. It could be empty files, but they must be executable.

The reason for requiring these script files in every project is because it allows having the whole API of ship-nix readily available in every configuration. Hidden features complicates and confuses in our opinion.

These scripts should be used sparingly, and you should prefer to configure stuff via Nix, but sometimes they are necessary for effectul actions like interacting with databases, file system or external APIs.

### scripts/after-rebuild

An executable script that is run **after deployment** (NixOS-rebuild) with actions that can't be done performed inside the nix configuration itself.

### scripts/before-rebuild

An executable script that is run **before deployment** (NixOS-rebuild) with actions that can't be done performed inside the nix configuration itself.

### scripts/provision

An executable script that with all the necessary actions for provisioning your project for the first time.

### ship.nix

This file contains configurations that are important for ship-nix to work.

We have decided to not ship this as a library, but rather just add it to your configuration.

You can make changes if needed, but be mindful that it might lead to that your project won't work with ship-nix.

```nix
# ship-nix mandatory settings
# IMPORTANT: These settings are essential for ship-nix to function properly on your server
# Modify with care

{ config, pkgs, modulesPath, lib, ... }:
{
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes ca-derivations
    '';
  };

  programs.git.enable = true;

  services.openssh = {
    enable = true;
    # ship-nix uses SSH keys to gain access to the server
    # Manage permitted public keys in the `authorized_keys` file
    passwordAuthentication = false;
    #  permitRootLogin = "no";
  };

  users.users.ship = {
    isNormalUser = true;
    extraGroups = [ "wheel" "nginx" ];
    openssh.authorizedKeys.keyFiles = [ ./authorized_keys ];
  };

  security.sudo.extraRules = [
    {
      users = [ "ship" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" "SETENV" ];
        }
      ];
    }
  ];

  nix.trustedUsers = [ "root" "ship" ];
}

```
