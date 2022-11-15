---
title: Nix and NixOS
layout: "base.njk"
eleventyNavigation:
  key: Nix
  title: Nix and NixOS
  parent: GetStarted
  order: 3
---

The package manager, language and operating system.

## Nix

Nix is a **package manager**. It works on Mac, Windows (WSL2) and pretty much any Linux distro.

- [Nix package manual](https://NixOS.org/manual/nix/stable/)

Nix is also a declarative **expression language**. You can use it to manage and configure web servers among other things.

- [Nix language reference](https://nixos.org/manual/nix/stable/language/index.html)

## NixOS

NixOS is the Linux distribution that Shipnix uses on all servers.

<blockquote><p>NixOS is a Linux distribution built on top of the Nix package manager. It uses declarative configuration and allows reliable system upgrades.</p>
<a target="_blank" href="https://en.wikipedia.org/wiki/NixOS">NixOS on Wikipedia</a>
</blockquote>

One benefit of NixOS is that you can manage you entire system configuration inside a git repo. Make your changes, push to git remote and rebuild the configuration.

- [NixOS manual](https://NixOS.org/manual/NixOS/stable/)
