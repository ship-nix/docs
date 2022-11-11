---
title: Nix and NixOS
layout: "base.njk"
eleventyNavigation:
  key: InstallNix
  title: Nix and NixOS
  parent: Nix
  order: 3
---

## What is Nix?

Nix is a **package manager**. You can run it on Mac, Windows (WSL2) and you can install it on almost any Linux distro.

- [Nix package manual](https://NixOS.org/manual/nix/stable/)

Nix is also a declarative **expression language** that you can use to manage and configure web servers and desktop computers among other things.

- [Nix language reference](https://nixos.org/manual/nix/stable/language/index.html)

NixOS is a Linux distribution.

It's built on the Nix package manager and configure by the declarative Nix expression language.

It's radically different from other Linux distros, focusing on declarative configuration, reproducability and reliability.

One benefit of NixOS is that you can manage you entire system configuration inside a git repo. Make your changes, push to git remote and rebuild the configuration.

- [NixOS manual](https://NixOS.org/manual/NixOS/stable/).

ship-nix can bootstrap Nix servers for you in various, and deploy them as the first thing you do when starting a project.
