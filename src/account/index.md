---
title: Account
layout: "base.njk"
eleventyNavigation:
  key: Account
  title: Account
---

## User dashboard

You manage account data like your email address, password, delete user and manage github integration in your <a target="_blank" href="https://ship-nix.com/ShowUser">user dashboard</a>.

## Deleting your account

You can delete your user from the dashboard. This also deletes all your data associated with ship-nix, which can not be recovered.

Your servers remain intact in accordance to the "your server, your choice" directive of ship-nix.

But when you delete your user, there is no longer a connection between ship-nix and your servers.

**You must make sure you have SSH access from your computer to your server so you don`t lose access.**

Other stuff that gets deleted:

- Your custom NixOS images from ship-nix stored in your DigitalOcean account
- Delete all tracks of you from the ship-nix database
- Deploy keys that where created via ship-nix if you use the Github integration
