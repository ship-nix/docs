---
title: Speed up NixOS deployments
layout: "base.njk"
eleventyNavigation:
  key: SpeedUp
  title: Speed up deployments
  parent: Servers
  order: 9
---

If you want to avoid spending resources on building in your production server on-premise, NixOS has several <a href="https://nixos.org/manual/nix/stable/package-management/sharing-packages.html" target="_blank">neat strategies</a>.

<div class="bg-blue-100 rounded-lg py-5 px-6 mb-4 text-base text-blue-700 mb-3" role="alert">
  If you are building a new early-stage project without any current users, we recommend just letting your server do the job to ship faster and save costs. Such enhancements can be done later at any time when needed.
</div>

**This guide will guide you through using a [staging environment](/servers/staging-servers/) as a Nix store through SSH.**

The staging server does the building and testing, like a CI. Production just downloads the binaries it needs.

With this technique, {{site.name}} runs database migrations and ships compiled Elm (> 6.000 loc) and Haskell code (> 16.000 loc) in under a minute to production.

## Build only once with a staging server

This lets you build only once and deploy your production server in a blink. This can replace the need for a CI server.

We will assume the following:

- You have a production server on {{site.name}} named `yourapp` under the domain `yourapp.com`
- You have a staging server named `yourapp-stage` under the domain `stage.yourapp.com`

## Sign packages with a private/public key pair

First, log in to your staging server shell.

```
ssh ship@stage.yourapp.com
```

Make a `binary` folder inside `/etc/shipnix` and cd into it.

```
mkdir -p /etc/shipnix/binary
cd /etc/shipnix/binary
```

Next, generate a private and public key pair for your packages. Replace `stage.yourapp.com` with your actual staging server url.

```
nix-store --generate-binary-cache-key stage.yourapp.com cache-priv-key.pem cache-pub-key.pem
chown nix-ssh cache-priv-key.pem
chmod 600 cache-priv-key.pem
```

Print the contents of your **public key** and for example copy and paste it into an intermediate text document.

```
cat cache-pub-key.pem
```

## Note the SSH public key of your root user

Next, exit your staging sever shell and log into your `production server`.

```
ssh ship@yourapp.com
```

Log into the root user and print the contents of the public key file, and also copy this to your intermediary text document.

```
sudo su root
cat /root/.ssh/id_rsa.pub
```

The next steps will be done in your NixOS configuration in your project repository.

## NixOS configuration

Thanks to the `environment` value defined in your Nix flake, you can have conditional declarations for your staging and production servers.

In your `configuration.nix`, enable the `sshServe` service and copy the SSH key belonging to the root user.

Also note `nix.extraOptions` where you declare your secret key file.

```nix
  nix.sshServe.enable = if environment == "stage" then true else false;
  nix.sshServe.keys =
    if environment == "stage" then [
      "ssh-rsa AAAAB7.....lRprYrxVovLdsdIekNosYxcrhtoTe7vyTOUT6xc="
    ] else [ ];
  nix.extraOptions =
    if environment == "stage" then ''
      secret-key-files = /etc/shipnix/binary/cache-priv-key.pem
    '' else "";
```

If you have `site.nix` file, check first if you already have `nix.settings.substituters` and `nix.settings.trusted-public-keys` declarations there and just update these.

Otherwise, you can just as well put it into your `configuration.nix`.

Replace `ssh://stage.yourapp.com` with your server, and paste in the public key you noted earlier that is used to sign your Nix packages:

```nix
  nix.settings.substituters =
    if environment == "production" then [
      "ssh://stage.yourapp.com"
    ] else [];
  nix.settings.trusted-public-keys =
    if environment == "production" then [
      "stage.yourapp.com:mB9FSh9.......Yg3Fs=""
    ] else [];
```

This should be all there is to it.

First deploy your staging server on through the server dashboard.

When this deploy is finished, try deploying your production server. You should notice a considerable speed-up.
