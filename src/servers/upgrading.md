---
title: Update and upgrade your server
layout: "base.njk"
eleventyNavigation:
  key: Upgrading
  title: Update and upgrade
  parent: Servers
  order: 7
---

Keeping your system updated is vital for server management.

In ship-nix, you can do this with a lot of peace of mind. Especially if you test it on a staging server first 👈

<div class="bg-blue-100 rounded-lg py-5 px-6 mb-4 text-base text-blue-700 mb-3" role="alert">
  We recommend keep this commit clean, and don't add other stuff, so you can safely rollback, just in case.
</div>

## Update packages

On your local machine, at the root of your repository, run

```bash
nix flake update
```

If this went without without error, you can commit this change, push it and push the `Deploy` button on your ship-nix dashboard.

And if the deployment was successful, your server has been upgraded 🙂

<div class="bg-blue-100 rounded-lg py-5 px-6 mb-4 text-base text-blue-700 mb-3" role="alert">
  On business critical software, test your update on a <a class="text-blue-700" href="/servers/staging-servers/">staging server</a> before production
</div>

## Upgrade NixOS version

If a newer NixOs version has been released, you can go to your `flake.nix` file and find `inputs.nixpkgs.url`.

```nix
{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.05";
    ...
  };
  ...
}
```

<div class="bg-red-100 rounded-lg py-5 px-6 mb-4 text-base text-red-700 mb-3" role="alert">
  Do not change <code>system.stateVersion</code> in your configuration.nix! This must show the version you had when your server was created.
</div>

Change it to a newer version, for example like this:

```nix
{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11";
    ...
  };
  ...
}
```

Then update the `flake.lock`:

```nix
nix flake update
```

Commit, push and click the `Deploy` button from your server dashboard.

Your NixOs server should have upgraded to the latest version.

You can SSH into your server and type `nixos-version` to verify that the upgrade was successful.

<div class="bg-blue-100 rounded-lg py-5 px-6 mb-4 text-base text-blue-700 mb-3" role="alert">
  On business critical software, test your system upgrade on a <a class="text-blue-700" href="/servers/staging-servers/">staging server</a> before production
</div>
