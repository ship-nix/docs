---
title: Set up on ship-nix.com
layout: "base.njk"
eleventyNavigation:
  key: SetUpShipNix
  title: Set up ship-nix.com
  parent: GetStarted
  order: 1
---

You can register for ship-nix with email/password or Github login.

After registration, there are a few initial steps before you can create a server.

## Github login

The Github login has a several benefits like quicker login.

It also simplifies connecting with Github, so ship-nix can create new repositories and deploy keys for you.

ship-nix **can not delete** repositories.

<a href="/images/githublogin.webp"><img src="/images/githublogin.webp" /></a>

## Add server provider credentials

After registering, provide your credentials from DigitalOcean.

Log in or register at [digitalocean.com](https://www.digitalocean.com/).

Then, navigate to `API` and click `Generate New Token`

<a href="/images/digitalocean-api.webp"><img src="/images/digitalocean-api.webp" /></a>

Give your token a name and make sure it has **both read and write** permissions.

<a href="/images/digitalocean-access-token.webp" ><img src="/images/digitalocean-access-token.webp" /></a>

The actual token key will only visible once, so make sure to copy it right away.

<a href="/images/digitalocean-generated-token.webp"><img src="/images/digitalocean-generated-token.webp" /></a>

Inside ship-nix, select `Access Control`. Insert the access token you copied from DigitalOcean.

`Token name` can be anything. It can be convenient to name it the same as you did in DigitalOcean to better remember it.

<a href="/images/ship-nix-access-control.webp"><img src="/images/ship-nix-access-control.webp" /></a>
