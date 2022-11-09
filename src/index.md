---
title: Introduction
layout: "base.njk"
eleventyNavigation:
  key: Introduction
  title: Introduction
---

# Introduction

**ship-nix** is a service for provisioning **NixOS** servers in a few minutes from a web interface.

You can use ship-nix to initiate a starter project with good defaults and host it on DigitalOcean.

You can select from a wide range of one-click starter projects like for example a Minecraft server, your self-hosted VPN or a web server of many differents sorts.

<div style={{paddingY: '2rem'}}>
    <img src="/img/nix-snowflake.svg" style={{maxWidth: "100px"}} />
    <div style={{fontSize: "0.8rem"}}>Attribution: NixOS organization under <a href="https://github.com/NixOS/nixos-artwork/tree/master/logo">CC-BY license</a></div>
</div>

## What is ship-nix?

## What is Nix?

Nix is a **package manager** that runs on Mac, Windows (WSL2) and most Linux distros from Ubuntu to Arch. Nix is also a declarative (**expression language** that you can use to manage and configure web servers among other things.

- [Read the Nix manual](https://nixos.org/manual/nix/stable/)

NixOS is a Linux distribution. It uses Nix as a package manager and you configure it with the Nix expression language. It's radically different from other Linux distros, focusing on declarative configuration, reproducability and reliability.

One great benefit of NixOS is that you can manage you entire system configuration inside a git repo. Make your changes, push to git remote and rebuild the configuration.

ship-nix servers are exclusively run on NixOS.

- [Read the NixOS manual](https://nixos.org/manual/nixos/stable/).

ship-nix can bootstrap Nix servers for you in various, and deploy them as the first thing you do when starting a project.

### How do I search in the Nix package registry?

On nixos.org, you can search for all packages that are provided via the registry. Packages from this registry can be installed from the Nix package manager CLI or declared in a Nix expression.

- [Search Nix packages](https://search.nixos.org/packages)

### How do I find out what configuration options are available in NixOS?

Also, on nixos.org, you can search for every configuration option available.

Try to for example search for `nginx`, and see all the options that comes up related to configuring nginx.

You can also try to search for `services.nginx` to find all the options within that namespace, exluding results from other services that have nginx options, but not directly linked to the nginx service.

- [Search for NixOS configurations options](https://search.nixos.org/options?)

## Cost considerations

ship-nix has a small monthly or annual cost, but it's also important to remember that this is a service that communicates with your DigitalOcean account.

Therefore, you must factor in the costs of the DigitalOcean services you are managing in your server budget.

## What you'll need to use ship-nix

- A [DigitalOcean](https://m.do.co/c/d475371ec0e6) account
- [Git](https://git-scm.com/) version control installed on your computer
- Git remote version control service like for example [Github](https://github.com)

## What you should know

If you are an absolute beginner, we figured it might be nice to have a list of some basic skills you should master before starting to use ship-nix.

### Git

At a minimum, you should know how the basics of how Git works if you want to configure servers via ship-nix.

You don't need to learn every command. `git add`, `git commit` and `git push` will be mostly all you need.

There are plenty of resources for Git, for example this tutorial on [FreeCodeCamp](https://www.freecodecamp.org/news/learn-the-basics-of-git-in-under-10-minutes-da548267cc91/).

### Linux

Some familiarity with how Linux works is nice to have, but not strictly required for provisioning a server unless you need to advanced custom stuff.

### How to read documentation

**ship-nix** only provides support on **ship-nix** itself.

If you are tinkering with the servers and customizing beyond what ship-nix offers, you need to do your own research.

- If you are looking for documentation on **configuration options**, do a search on [NixOS options search](https://search.nixos.org/options?)
- If you need to know what packages are available, do a search on [NixOS packages search](https://search.nixos.org/packages?)
- If you're stuck on something advanced Nix related, please refer to the [https://nixos.org/](https://nixos.org/) website, where there is lots of documentation, and an active and friendly community.
