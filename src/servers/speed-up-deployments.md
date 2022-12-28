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

Some of these strategies can let you ship binaries from your local machine. Others are suited for sharing binaries between servers.

Also consider <a href="https://www.cachix.org/">Cachix</a>, a highly trusted managed Nix binary cache as a service that can take care of all this for you.

<div class="bg-blue-100 rounded-lg py-5 px-6 mb-4 text-base text-blue-700 mb-3" role="alert">
  If you are building a new early-stage project without any current users, we recommend just letting your main server do the job as an all-in-one solution to ship faster and save costs + complexity. Such enhancements can be done later at any time when needed.
</div>

## Use staging server to speed up builds in production

**This tutorial will guide you through using a [staging environment](/servers/staging-servers/) as a Nix store via SSH in detailed steps.**

- Read [instructions on how to set up a staging server](/servers/staging-servers/) if you don't already have one

The advantage of using the SSH technique is that you will get an automated private binary cache that doest not expose proprietary code publicly. The downside is that it's a slightly annoying to setup because it's not really possible to do all of this declaratively.

With this technique, {{site.name}} runs database migrations and ships compiled Elm (>6.000 loc) and Haskell code (>16.000 loc, not including framework) in under 30 seconds in production.

It lets you build only once and the staging server can this way easily double down as a CI server.

We will assume the following example:

- You have a production server on {{site.name}} named `yourapp` under the domain `yourapp.com`
- You have a staging server named `yourapp-stage` under the domain `stage.yourapp.com`

<div class="bg-blue-100 rounded-lg py-5 px-6 mb-4 text-base text-blue-700 mb-3" role="alert">
  <span class="font-bold">Setting this up this strategy is a bit awkward</span>, requiring some imperative steps jumping around in different contexts. We advise you to read the instructions thoroughly and follow the steps precisely and in the correct order. We will try to overexplain the steps to prevent misunderstandings.
</div>

### Sign packages with a private/public key pair

Sharing your binaries between servers requires you to sign your packages with a private/public keypair.

First, log in to the shell of your **staging server**.

```
ssh ship@stage.yourapp.com
```

From here, log into root

```
sudo su root
```

Create a `binary` folder inside `/etc/shipnix` and cd into it.

```
mkdir -p /etc/shipnix/binary
cd /etc/shipnix/binary
```

Next, generate a private and public key pair for your packages. **Replace `stage.yourapp.com` with your actual staging server url.**

```
nix-store --generate-binary-cache-key stage.yourapp.com cache-priv-key.pem cache-pub-key.pem
```

Print the contents of the **public key**. Copy and paste the key into an intermediate text document for later use.

```
$ cat cache-pub-key.pem
stage.yourapp.com:T0xDDpZbMep2GjjzGDpRk32FkZx/+LZ4eKqPyGI2il8=
```

### Note the SSH **public key** of your root user

In this step, we will need to take note of another public key, the one belonging to your root user on your `production` server, which is responsible for rebuilding NixOS.

Start a new ssh session into your `production` server.

```
ssh ship@yourapp.com
```

Log into the root user and print the contents of the **public key** file. Also copy this key to your intermediary text document. They should be easy to differentiate because one is shorter and has a different prefix.

```sh
$ sudo su root
$ cat /root/.ssh/id_rsa.pub
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCWT75hPseOBJUWDRZIzrGkNcubS1D+g1hTf72nKr9sUxVA8nLfGE6WAIjOW+bLHdWQXjJH5Bhodv5t6bpY1sBi3NuQq4xcH3yGd52SlzE5dgGl4psRdA+VQXpHfsnrjZ+6LPVBVdaZjdHgq7IR1b7rOBJCtdBJXSjNyZvagghBPKe4a+4Unpg+Y09+/p0BkaNHZmpVc43OHuC4drMpnqWiqNtMoq6gqAL5Ifu+FQHG3JGHLi/QUS2ee667IiIXYX9w4BMB1+W1Rle+PvpJwWuIj12DufAUWceOzk1iipAPgKvFYs6ZC+0Ldyczu+upQBTXHmKtRaS9bdQjSg72v3eAOymMNAeKZlLo3+VhxfAh7BpQ7ER6xy7hStbYjerIWdxx/WLgoGqUOkUBMynxOP3pWZTyb4BBdSObaFJ9O2F1XlmxRg3s+hb/pqqprxuJ8iT5T8uuLi6TyeB7auXF0g/T40CPCVwCPthY9Z9pSZ9zIpv8beaWiakvs7RbYz8d6OE= ship@yourapp
```

### Add **sshServe** configuration

Now that these steps are done, add these rules to your `configuration.nix`. Replace the example public key with the root public key (the long one) you stored earlier.

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

This enables a special user in your staging server named `nix-ssh` that will do the job of sharing binaries over SSH. In `nix.extraOptions`, you declare the location of the signing private key to enable secure communication with your production server.

**Now you can commit, push and deploy. You only need to deploy the `stage` server for now.**

Next, return to the root shell of your **production server** or spin up a new session again like this:

```
ssh ship@stage.yourapp.com
```

and

```
sudo su root
```

**Still from the production server**, make an attempt at ssh-ing into your `nix-ssh` user shell.

```
$ ssh nix-ssh@yourapp.com
```

You will be prompted to verify the host. Just type `yes` and hit enter.

You will be denied access with an error message saying `PTY allocation request failed on channel 0`. This is expected as you are not supposed to access this user via SSH. The important thing was that you added your staging server to `known_hosts`.

This is a confusing extra step, but should not be missed as your build will hang, waiting for someone to answer this prompt interactively if you don't do this manually first.

### Final bit of NixOS configuration

The difficult bit is now over.

Now, you can add the following rules below to your configuration.nix.

Remember to replace `ssh://nix-ssh@stage.yourapp.com` corresponding to your staging server. Paste in the public key (the shorter one) you noted earlier that is used to sign your Nix packages:

```nix
  nix.settings.substituters =
    if environment == "production" then [
      "ssh://nix-ssh@stage.yourapp.com"
    ] else [];
  nix.settings.trusted-public-keys =
    if environment == "production" then [
      # the trusted sshServe public key
      "stage.yourapp.com:T0xDDpZbMep2GjjzGDpRk32FkZx/+LZ4eKqPyGI2il8="
    ] else [];
```

**If you already have some `substituters` and `trusted.public-keys` settings defined in your configuration, make sure you insert the already existing values in both the `production` and `else` case.**

All the configuration should be done now.

First deploy your staging server through the server dashboard.

When the staging deploy is finished, try deploying your production server.

You should notice a considerable speed-up already on the first deploy, and for future deploy as long as you deploy the staging server first.

Phew!
