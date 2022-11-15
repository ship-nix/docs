---
title: Deployment
layout: "base.njk"
eleventyNavigation:
  key: Deployment
  title: Deployment
  parent: Servers
  order: 2
---

Simply click on the `Deploy` button in your server dashboard. It automatically pulls from your git provider, and deploys your server.

<img src="/images/deploy-btn-migrate.webp"/>

## Deploy actions

There are a couple of options to be aware of in the `Deploy options` box.

<img src="/images/deploy-options.webp"/>

### Branch/commit hash

The default branch is `origin/main`.

The **origin/** prefix sets the repo to a remote tracking branch.

If your default branch is something else, like `master`, you must change to `origin/master`

#### Rollback to a certain commit

You can rollback your server configuration back in time by inputting a commit hash like `d07c66e` into the `Branch/commit hash` input.

When you click `Deploy`, it will rollback your configuration to this earlier version.

Databases are not affected.

**Always test a rollback on a staging server before production to make sure it doesn't do something unintended**

### Build with --impure flag

If you are able to deploy in without the `--impure` flag, then all is good, and this is generally the preferred way in NixOS.

Some nix configurations are _impure_, meaning for example that they require you connect to the internet to fulfil.

For example [IHP](/starters/ihp/#must-run-in-impure-mode) needs impure mode because of how their nix config is currently written.
