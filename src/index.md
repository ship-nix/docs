---
title: Introduction
layout: "base.njk"
eleventyNavigation:
  key: GetStarted
  title: Introduction
  order: 1
---

**ship-nix** is a web UI for provisioning, managing and deploying **NixOS** servers.

You can use ship-nix to initiate a starter project with good defaults and host it on DigitalOcean.

You can select from a several "one-click" starter projects like IHP and barebones or get inspired by some of the guides in the [NixOS manual](https://NixOS.org/manual/NixOS/stable/) 🤩

<img class="w-48 h-48" alt="The NixOS logo" src="/images/nix-snowflake.svg"/>
<div class="text-sm">Attribution: NixOS organization under <a href="https://github.com/NixOS/NixOS-artwork/tree/master/logo">CC-BY license</a></div>

## What's different about ship-nix?

ship-nix is for everyone who wansts to maintain a web server in Nix. The aim is to be both beginner and expert-friendly.

Instead of being a Platform as a Service that does the managing and hosting for your, ship-nix gives you a running server and generates code for you to further build on.

Declarative configuration keeps you more in your code editor and less patching your server live.

ship-nix has [starters for different types of tech stacks](/starters/).

- [NixOS package search](https://search.NixOS.org/packages)

## How do I find out what configuration options are available in NixOS?

Also, on NixOS.org, you can search for every configuration option available.

Try to for example search for `nginx`, and see all the options that comes up related to configuring nginx.

You can also try to search for `services.nginx` to find all the options within that namespace, exluding results from other services that have nginx options, but not directly linked to the nginx service.

## Other important documentation

- [NixOS options search](https://search.NixOS.org/options?)

- If you are looking for documentation on **configuration options**, do a search on [NixOS options search](https://search.NixOS.org/options?)
- If you need to know what packages are available, do a search on [NixOS packages search](https://search.NixOS.org/packages?)
- If you're stuck on something advanced Nix related, please refer to the [https://NixOS.org/](https://NixOS.org/) website, where there is lots of documentation, and an active and friendly community.
