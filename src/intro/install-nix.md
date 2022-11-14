---
title: Install essentials
layout: "base.njk"
eleventyNavigation:
  key: InstallNix
  title: Install essentials
  parent: GetStarted
  order: 2
---

## Install Nix

[Follow the instructions on NixOS.org](https://NixOS.org/download.html#download-nix) to install Nix on your machine.

## Enable flakes

Flakes are still considered an experimental feature in NixOS, so you will have to enable them.

NixOS wiki has [instructions on how to enable flakes](https://NixOS.wiki/wiki/Flakes#Enable_flakes).

## Direnv

Direnv is a shell extension that enables you to load up you nix environment in the shell of your project directory.

It provides the best developer experience for most starters.

There are two steps for installing direnv. **Installing it on your system** and **hooking up your shell**.

You can install direnv in your favorite package manager Nix 😗

- [NixOS.org install instructions](https://search.NixOS.org/packages?show=direnv)

Hooking into your shell is well documented on the official direnv site

- [direnv official instructions for hooking into the shell](https://direnv.net/docs/hook.html)
