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

Some can let you build binaries on your local machine. Others are suited for sharing binaries between servers.

<div class="bg-blue-100 rounded-lg py-5 px-6 mb-4 text-base text-blue-700 mb-3" role="alert">
  If you are building a new early-stage project without any current users, we recommend just letting your server do the job to ship faster and save costs. Such enhancements can be done later at any time when needed.
</div>
<!-- 
## Use staging server to speed up builds in production

**This guide will guide you through using a [staging environment](/servers/staging-servers/) as a Nix store with SSH.**

The staging server does the building and testing, like a CI. Production automatically and securely downloads the binaries it needs directly from the staging server.

With this technique, {{site.name}} runs database migrations and ships compiled Elm (> 6.000 loc) and Haskell code (> 16.000 loc) in under a minute in production.

This lets you build only once and deploy your production server in a blink. This can replace the need for a CI server.

We will assume the following:

- You have a production server on {{site.name}} named `yourapp` under the domain `yourapp.com`
- You have a staging server named `yourapp-stage` under the domain `stage.yourapp.com`

### Sign packages with a private/public key pair

First, log in to your staging server shell.

```
ssh ship@stage.yourapp.com
```

Log into root

```
sudo su root
```

Create a `binary` folder inside `/etc/shipnix` and cd into it.

```
mkdir -p /etc/shipnix/binary
cd /etc/shipnix/binary
```

Next, generate a private and public key pair for your packages. Replace `stage.yourapp.com` with your actual staging server url.

```
nix-store --generate-binary-cache-key stage.yourapp.com cache-priv-key.pem cache-pub-key.pem
```

Print the contents of your **public key** and for example copy and paste it into an intermediate text document.

```sh
$ cat cache-pub-key.pem
stage.yourapp.com:T0xDDpZbMep2GjjzGDpRk32FkZx/+LZ4eKqPyGI2il8=
```

### Note the SSH **public key** of your root user

Next, **exit your staging sever shell** and log into your `production server`.

```
ssh ship@yourapp.com
```

Log into the root user and print the contents of the **public key** file, and also copy this to your intermediary text document.

```sh
$ sudo su root
$ cat /root/.ssh/id_rsa.pub
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCWT75hPseOBJUWDRZIzrGkNcubS1D+g1hTf72nKr9sUxVA8nLfGE6WAIjOW+bLHdWQXjJH5Bhodv5t6bpY1sBi3NuQq4xcH3yGd52SlzE5dgGl4psRdA+VQXpHfsnrjZ+6LPVBVdaZjdHgq7IR1b7rOBJCtdBJXSjNyZvagghBPKe4a+4Unpg+Y09+/p0BkaNHZmpVc43OHuC4drMpnqWiqNtMoq6gqAL5Ifu+FQHG3JGHLi/QUS2ee667IiIXYX9w4BMB1+W1Rle+PvpJwWuIj12DufAUWceOzk1iipAPgKvFYs6ZC+0Ldyczu+upQBTXHmKtRaS9bdQjSg72v3eAOymMNAeKZlLo3+VhxfAh7BpQ7ER6xy7hStbYjerIWdxx/WLgoGqUOkUBMynxOP3pWZTyb4BBdSObaFJ9O2F1XlmxRg3s+hb/pqqprxuJ8iT5T8uuLi6TyeB7auXF0g/T40CPCVwCPthY9Z9pSZ9zIpv8beaWiakvs7RbYz8d6OE= ship@yourapp
```

The next steps will be done in your NixOS configuration in your project repository.

### NixOS configuration

Thanks to the `environment` value defined in your Nix flake, you can have conditional declarations for your staging and production servers.

In your `configuration.nix`, enable the `sshServe` service and copy the SSH key belonging to the root user.

Also note `nix.extraOptions` where you declare your secret key file.

```nix
  nix.sshServe.enable = if environment == "stage" then true else false;
  nix.sshServe.keys =
    if environment == "stage" then [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCWT75hPseOBJUWDRZIzrGkNcubS1D+g1hTf72nKr9sUxVA8nLfGE6WAIjOW+bLHdWQXjJH5Bhodv5t6bpY1sBi3NuQq4xcH3yGd52SlzE5dgGl4psRdA+VQXpHfsnrjZ+6LPVBVdaZjdHgq7IR1b7rOBJCtdBJXSjNyZvagghBPKe4a+4Unpg+Y09+/p0BkaNHZmpVc43OHuC4drMpnqWiqNtMoq6gqAL5Ifu+FQHG3JGHLi/QUS2ee667IiIXYX9w4BMB1+W1Rle+PvpJwWuIj12DufAUWceOzk1iipAPgKvFYs6ZC+0Ldyczu+upQBTXHmKtRaS9bdQjSg72v3eAOymMNAeKZlLo3+VhxfAh7BpQ7ER6xy7hStbYjerIWdxx/WLgoGqUOkUBMynxOP3pWZTyb4BBdSObaFJ9O2F1XlmxRg3s+hb/pqqprxuJ8iT5T8uuLi6TyeB7auXF0g/T40CPCVwCPthY9Z9pSZ9zIpv8beaWiakvs7RbYz8d6OE= ship@yourapp"
    ] else [ ];
  nix.extraOptions =
    if environment == "stage" then ''
      secret-key-files = /etc/shipnix/binary/cache-priv-key.pem
    '' else "";
```

Also add the rules below to your configuration.nix.

Replace `ssh://stage.yourapp.com` with your server, and paste in the public key you noted earlier that is used to sign your Nix packages:

```nix
  nix.settings.substituters =
    if environment == "production" then [
      "ssh://nix-ssh@stage.yourapp.com"
    ] else [];
  nix.settings.trusted-public-keys =
    if environment == "production" then [
      "stage.yourapp.com:T0xDDpZbMep2GjjzGDpRk32FkZx/+LZ4eKqPyGI2il8="
    ] else [];
```

This should be all there is to it.

First deploy your staging server through the server dashboard.

When this deploy is finished, try deploying your production server. You should notice a considerable speed-up. -->
