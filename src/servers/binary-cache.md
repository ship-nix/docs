---
title: Binary cache
layout: "base.njk"
eleventyNavigation:
  key: BinaryCache
  title: Binary cache
  parent: Servers
  order: 9
---

A binary cache is a collection of prebuilt binaries that can speed up server build considerably.

## Use staging server as a binary cache

If you have a staging server, it's not only useful for testing before pushing to production.

A staging server can also function as a Nix binary cache, so your production server can download the binaries that were built.

This is beneficial since it will require minimal RAM and CPU to rebuild in production.

- [Read instructions from NixOS wiki on how to set up a binary cahce](https://NixOS.wiki/wiki/Binary_Cache)

## Managed binary caches

If you want to host your binary caches through an external service, <a target="_blank" href="https://www.cachix.org/">Cachix</a> offers "binary cache as a service".
