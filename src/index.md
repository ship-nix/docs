---
title: Introduction
layout: "base.njk"
eleventyNavigation:
  key: GetStarted
  title: Introduction
  order: 1
---

**ship-nix** is a service for provisioning and deploying **NixOS** servers from a web interface.

You can use ship-nix to initiate a starter project with good defaults and host it on DigitalOcean.

You can select from a several "one-click" starter projects like IHP and barebones or get inspired by some of the guides in the [NixOS manual](https://NixOS.org/manual/NixOS/stable/) 🤩

<img class="w-48 h-48" alt="The NixOS logo" src="/images/nix-snowflake.svg"/>
<div class="text-sm">Attribution: NixOS organization under <a href="https://github.com/NixOS/NixOS-artwork/tree/master/logo">CC-BY license</a></div>

## What's different about ship-nix?

ship-nix intended for those who want to get quickly started with maintaining a web server in Nix.

Unlike for example Heroku, ship-nix itself does not host your server. But like Heroku it lets you create a fully working server from a web dashboard.

There things you configure via the Heroku UI, like setting up a database. With ship-nix. This you do it in a `.nix` file checked into source control, and the database costs nothing extra. Of course you can instead hook up a managed database with an external provider if you prefer that.

## What is Nix?

Nix is a **package manager** that runs on Mac, Windows (WSL2) and most Linux distros from Ubuntu to Arch. Nix is also a declarative (**expression language** that you can use to manage and configure web servers among other things.

- [Read the Nix manual](https://NixOS.org/manual/nix/stable/)

NixOS is a Linux distribution. It uses Nix as a package manager and you configure it with the Nix expression language. It's radically different from other Linux distros, focusing on declarative configuration, reproducability and reliability.

One great benefit of NixOS is that you can manage you entire system configuration inside a git repo. Make your changes, push to git remote and rebuild the configuration.

ship-nix servers are exclusively run on NixOS.

- [Read the NixOS manual](https://NixOS.org/manual/NixOS/stable/).

ship-nix can bootstrap Nix servers for you in various, and deploy them as the first thing you do when starting a project.

### How do I search in the Nix package registry?

On NixOS.org, you can search for all packages that are provided via the registry. Packages from this registry can be installed from the Nix package manager CLI or declared in a Nix expression.

- [Search Nix packages](https://search.NixOS.org/packages)

### How do I find out what configuration options are available in NixOS?

Also, on NixOS.org, you can search for every configuration option available.

Try to for example search for `nginx`, and see all the options that comes up related to configuring nginx.

You can also try to search for `services.nginx` to find all the options within that namespace, exluding results from other services that have nginx options, but not directly linked to the nginx service.

- [Search for NixOS configurations options](https://search.NixOS.org/options?)

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

- If you are looking for documentation on **configuration options**, do a search on [NixOS options search](https://search.NixOS.org/options?)
- If you need to know what packages are available, do a search on [NixOS packages search](https://search.NixOS.org/packages?)
- If you're stuck on something advanced Nix related, please refer to the [https://NixOS.org/](https://NixOS.org/) website, where there is lots of documentation, and an active and friendly community.
