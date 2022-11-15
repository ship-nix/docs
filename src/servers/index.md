---
title: Servers
layout: "base.njk"
eleventyNavigation:
  key: Servers
  title: Servers
  order: 3
---

There are some conventions for your project code to work with {{site.name}}.

Use the [Load existing code starter](/starters/migration/) to generate this code for you instead of building it manually.

## On server

Your current state of the source code lives in the `/home/ship/server` folder.

You can modify it and tinker with configurations via SSH, but a {{site.name}} deployment will remove these changes.

Your secrets and other more sensitive environment data lives in `/etc/ship-nix`, for example the `.env` file defines the global environment variables.

## In source code

First of all, {{site.name}} requires a `nixos` folder at the root of your project repository.

A {{site.name}} compatible projects folder must at minimum have these files:

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

This is the entrypoint for the NixOS system itself

- [Read more about configuration in NixOS manual](https://NixOS.org/manual/NixOS/stable/)

### flake.nix

{{site.name}} is built on flakes because we believe it's the upcoming way to use Nix.

Here is a good definition of what it is:

> A flake is simply a source tree (such as a Git repository) containing a file named flake.nix that provides a standardized interface to Nix artifacts such as packages or NixOS modules. Flakes can have dependencies on other flakes, with a “lock file” pinning those dependencies to exact revisions to ensure reproducible evaluation.
>
> > From [An introduction to Nix Flakes](https://www.tweag.io/blog/2020-05-25-flakes/) (tweag.io)

With a flake, you can declare your whole Nix configuration in your project repo and easily build it on your {{site.name}} server.

- [Read about Nix flakes on NixOS wiki](https://NixOS.wiki/wiki/Flakes)

### scripts/

Your {{site.name}} configuration must contain an executable **after-rebuild, before-rebuild and provision**.

These files can be empty and do nothing, but they must be executable.

These scripts should only be used when there are actions that can't be perfomer within your Nix flake.

### scripts/after-rebuild

An executable script that is run **after deployment** (NixOS-rebuild) with actions that can't be done performed inside the nix configuration itself.

### scripts/before-rebuild

An executable script that is run **before deployment** (NixOS-rebuild) with actions that can't be done performed inside the nix configuration itself.

### scripts/provision

An executable script that with all the necessary actions for provisioning your project for the first time.

### ship.nix

This file contains configurations that are important for {{site.name}} to work.

We have decided to not ship this as a library, but rather just add it to your configuration.

You can make changes if needed.

Be mindful that disabling what's already defined here could cause problems in interaction with {{site.name}}.

```nix
# {{site.name}} mandatory settings
# IMPORTANT: These settings are essential for {{site.name}} to function properly on your server
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
    # {{site.name}} uses SSH keys to gain access to the server
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
