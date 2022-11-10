---
title: Speed up deployments
layout: "base.njk"
eleventyNavigation:
  key: SpeedUp
  title: Speed up deployments
  parent: Servers
  order: 9
---

A binary cache is a collection of prebuilt binaries that can speed up server build.

## Use staging server as a binary cache

If you have a staging server, it's not only useful for testing before pushing to production.

A staging server can also function as a Nix binary cache, so your production server can download the binaries that were built.

This is beneficial since it will require minimal RAM and CPU to rebuild in production.

- [Read instructions from NixOS wiki on how to set up a binary cahce](https://NixOS.wiki/wiki/Binary_Cache)

## Managed binary caches

If you want to host your binary caches through an external service, <a target="_blank" href="https://www.cachix.org/">Cachix</a> offers "binary cache as a service".

### Binary cache

Any NixOS machine can act as a binary cache.

A binary cache can speed up deploys by sharing binaries between NixOS machines.

If you have a staging server, you can use it as a binary cache for your production server.

- [Read about binary cache on NixOS Wiki](https://NixOS.wiki/wiki/Binary_Cache)

### nix-copy-closure

You can prebuild a project on your local machine, and then send store-fresh builds to your server with <a target="_blank" href="https://NixOS.org/manual/nix/stable/command-ref/nix-copy-closure.html">nix-copy-closure</a>.

First build in a project with

```bash
nix build
```

Then run nix-copy-closure to send the binaries to your server.

```bash
nix-copy-closure --to ship@yourserver.com result
```

This technique can for example be useful for Haskell servers because you can pre-compile on you local more powerful machine and save on resources in production.

### Resize server

If none of the above technique does not work for you, the server runs out on memory and uses swap a lot, it could be time to resize your server. This will result in a couple of minutes of downtime.
