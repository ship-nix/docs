---
title: Servers
layout: "base.njk"
eleventyNavigation:
  key: Servers
  title: Servers
  order: 3
---

All servers run on <a target="_blank" href="https://NixOS.org">NixOS</a>, which is a Linux distribution built on the Nix package manager.

The servers are configured locally on your own computer in `.nix` files.

In every project that runs on ship-nix, there is a `NixOS` folder containing `configuration.nix` which is the heart of the system declaration.

The `imports` declaration imports other `.nix` file that together add up to a complete NixOS declaration.

`site.nix` for example typically contains configuration for a web site.

`ship.nix` includes some defaults that ship-nix requires for working properly. But the freedom is ultimately yours to configure if you wish.
