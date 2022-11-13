---
title: Set up on ship-nix.com
layout: "base.njk"
eleventyNavigation:
  key: SetUpShipNix
  title: Set up ship-nix.com
  parent: GetStarted
  order: 1
---

You can register for ship-nix with email/password og Github auth, there are a few steps before you can create a server.

## Github auth

The Github login has a couple of benefits: quicker login, and enables ship-nix to act on your behalf to list or create new repositories and add deploy keys.

As you see from the permissions we ask for when logging in, ship-nix can create and push to repositories.

Repository deletion is not possible. All repo deletion needs to be done manually by yourself.

<a href="/images/githublogin.webp"><img src="/images/githublogin.webp" /></a>

## Add server provider credentials

As you have registered your new user, you will need to provide your API credentials from your DigitalOcean account.

Log in or register at [digitalocean.com](https://www.digitalocean.com/).

Then, navigate to `API` and click `Generate New Token`

<a href="/images/digitalocean-api.webp"><img src="/images/digitalocean-api.webp" /></a>

Give your token a name and make sure it has **both read and write** permissions.

<a href="/images/digitalocean-access-token.webp" ><img src="/images/digitalocean-access-token.webp" /></a>

When successfully generated, your access token will appear. The actual token key will only visible once, so make sure to copy it right away.

<a href="/images/digitalocean-generated-token.webp"><img src="/images/digitalocean-generated-token.webp" /></a>

Now, inside ship-nix, select `Access Control` and insert the access token you copied from DigitalOcean.

`Token name` can be anything, but it can be convenient to name it the same as you did in DigitalOcean to better remember it.

<a href="/images/ship-nix-access-control.webp"><img src="/images/ship-nix-access-control.webp" /></a>
