---
title: Servers
layout: "base.njk"
eleventyNavigation:
  key: Servers
  title: Servers
  order: 3
---

ship-nix is a web-based interface for creating working servers for you to manage as you like.

All servers run on <a href="https://NixOS.org">NixOS</a>, which is a Linux distribution built on the Nix package manager.

The servers are configured locally on your own computer in `.nix` files.

In every project that runs on ship-nix, there is a `NixOS` folder containing `configuration.nix` which is the heart of the system declaration.

The `imports` declaration imports other `.nix` file that together add up to a complete NixOS declaration.

`site.nix` for example typically contains configuration for a web site.

`ship.nix` includes some defaults that ship-nix requires for working properly. But the freedom is ultimately yours to configure if you wish.

## Creating servers

There are different ways of creating a server, depending on what you want to do.

### 1. Create a new project

Creating a server from ship-nix is a great way to start a new project.

1. Select a starter template, pick your hardware specs and create
2. Follow the git guide in your server dashboard to create a new repo with deploy key from your server
3. Pull the code to your computer and start developing

### 2. Create a server based on an existing repository

There are two ways to add an existing project.

#### a. Import a ship-nix compatible project

You can create a [staging server](/servers/staging-servers) or maybe you have a personal starter template.

#### b. Import a non-ship-nix project

If you have a project that has not yet been deployed on ship-nix, you can choose to **"shipnixify"** your code.

ship-nix will generate a script you can run locally on your machine to make the necessary changes to your repository.

## Deleting servers

If you wish to delete your server, this can be done from the ship-nix dashboard under **Settings**.

There are two ways of deleting a server from ship-nix.

### Eject

Ejecting your server means simply that data about your server is erased from ship-nix. Your server will **still exist**, just not on ship0nix.

<div class="bg-blue-100 rounded-lg py-5 px-6 mb-4 text-base text-blue-700 mb-3" role="alert">
  To ensure you still have access to the server without ship-nix, be sure that you are able to log into your server with <a class="text-blue-700" href="/servers/ssh">SSH</a>.
</div>

### Destroy server

Destroying your server will wipe your server from DigitalOcean and ship-nix.
