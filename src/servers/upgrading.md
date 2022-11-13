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

In ship-nix, you can do this with a lot of peace of mind. Especially if you test it on a [staging server first](/servers/staging-servers/) 👈

## Update packages

On your local machine, at the root of your repository, run

```bash
nix flake update
```

If this went without without error, you can commit, push and click the `Deploy` button on your ship-nix dashboard.

And if the deployment was successful, your server has been upgraded 🙂

<div class="bg-blue-100 rounded-lg py-5 px-6 mb-4 text-base text-blue-700 mb-3" role="alert">
  On business critical software, test your update on a <a class="text-blue-700" href="/servers/staging-servers/">staging server</a> before production
</div>

## Upgrade NixOS version

If a newer NixOS version has been released, you can go to your `flake.nix` file and find `inputs.nixpkgs.url`.

Change it to a newer version, for example like this:

```diff-nix
{
  inputs = {
-    nixpkgs.url = "nixpkgs/nixos-22.05";
+    nixpkgs.url = "nixpkgs/nixos-22.11";
    ...
  };
  ...
}
```

<div class="bg-red-100 rounded-lg py-5 px-6 mb-4 text-base text-red-700 mb-3" role="alert">
  Do not change <code>system.stateVersion</code> in your configuration.nix! This must show the version you had when your server was created.
</div>

Then update the `flake.lock`:

```nix
nix flake update
```

Commit, push and click the `Deploy` button from your server dashboard.

<div class="bg-blue-100 rounded-lg py-5 px-6 mb-4 text-base text-blue-700 mb-3" role="alert">
  On business critical software, test your system upgrade on a <a class="text-blue-700" href="/servers/staging-servers/">staging server</a> before production
</div>

Your NixOS server should have upgraded to the latest version.

You can [SSH into your server](/servers/ssh/) and type `nixos-version` to verify that the upgrade was successful.
