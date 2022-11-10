---
title: Servers
layout: "base.njk"
eleventyNavigation:
  key: Servers
  title: Servers
---

ship-nix is a web-based interface for creating working servers for you to manage as you like.

All servers run on <a href="https://NixOS.org">NixOS</a>, which is a Linux distribution built on the Nix package manager.

The servers are configured locally on your own computer in `.nix` files.

In every project that runs on ship-nix, there is a `NixOS` folder containing `configuration.nix` which is the heart of the system declaration.

A `configuration.nix` can for example look like this:

```nix

{ config, pkgs, modulesPath, lib, ... }:
{
  imports = lib.optional (builtins.pathExists ./do-userdata.nix) ./do-userdata.nix ++ [
    (modulesPath + "/virtualisation/digital-ocean-config.nix")
    ./ship.nix
    ./site.nix
  ];

  nix.settings.sandbox = false;

  # Add system-level packages for your server here
  environment.systemPackages = with pkgs; [
    bash
  ];

  # Automatic garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 80 443 22 5432 ];

  programs.vim.defaultEditor = true;
  services.fail2ban.enable = true;
  swapDevices = [{ device = "/swapfile"; size = 4096; }];

  system.stateVersion = "22.05";
}

```

The `imports` declaration imports other `.nix` file that together add up to a complete NixOS declaconfigurationration.

`site.nix` for example typically contains configuration for a web site.

`ship.nix` includes some defaults that ship-nix requires for working properly. But the freedom is ultimately yours to configure if you wish.
