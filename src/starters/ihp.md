---
title: IHP
layout: "base.njk"
eleventyNavigation:
  key: IHP
  parent: Starters
---

IHP is a batteries-included full-stack web framework written in Haskell.

- [IHP official documentation]()

The IHP starter comes with a fresh repository and a self-hosted, configured in advanced Postgres server.

## Add a domain and https

As soon as you create a new IHP server, it will only be available through your public IP address.

**Follow these guides to add a domain name and https**

- [See the domain name section](/servers/add-domain)
- [See the https section](/servers/https)

In addition, you would have to go to the **Environment** tab in your server dashboard and set the primary domain name in the environment variables.

```bash
IHP_BASEURL=https://yourdomain.com
```

## Enable jobs

[IHP jobs](https://ihp.digitallyinduced.com/Guide/jobs.html#jobs) must be enabled in the `site.nix` file.

```nix
{ config, lib, pkgs, docs, environment, ... }:
let
  ihpApp = import ../.;
  # TODO: Enable SSL
  # By enabling SSL, you accept the terms and conditions of LetsEncrypt
  isHttpEnabled = true;
  jobsEnabled = true;
in
```

## Deploy IHP in optimized mode

The default ghc compilation flag for IHP is `-01`.

According to GHC docs, the `-01` flags means `Generate good-quality code without taking too long about it.` In other words, more than good enough for most usecases, and rebuilds are very quick on ship-nix.

Optimized mode compiles your IHP project in GHC optimization flag `-02`.

`-02` translates to `Apply every non-dangerous optimisation, even if it means significantly longer compile times.`. And it delivers on significantly longer, especially in an IHP project.

- [GHC optimization flags](https://downloads.haskell.org/ghc/latest/docs/users_guide/using-optimisation.html#o-convenient-packages-of-optimisation-flags)

To enable optimized mode, go to your `default.nix` add the `optimize` option.

```diff-nix
    ...
    ];
    otherDeps = p: with p; [
      # Native dependencies, e.g. imagemagick
    ];
    projectPath = ./.;
+   optimized = true;
  };
in
haskellEnv
```

<div class="not-prose bg-blue-100 rounded-lg py-5 px-6 mb-4 text-base text-blue-700 mb-3" role="alert">
  <p><strong>Ask yourself:</strong> Will my users notice this optimization?</p>
  <p class="pt-4"><strong>ship-nix's opinion:</strong> Beware of premature optimization. Only go with optimized mode if you are having performance issues and optimized mode is the best way to solve it.</p>
</div>

## Must run in impure mode

IHP is packaged with Nix, but have not yet been updated to work with Nix flakes yet.

IHP servers must be run with the `--impure` flag, meaning this switch must be turned on like this in the IHP dashboard.

<img class="border" src="/images/impure-switch.jpg" />
