---
title: Deployment
layout: "base.njk"
eleventyNavigation:
  key: Deployment
  title: Deployment
  parent: Servers
  order: 2
---

Deployment in ship-nix is fairly simple. Simply click on the `Deploy` button in your server dashboard. It pulls from your git provider and deploys.

There are a couple of options to be aware of in the `Deploy options` box.

### Branch/commit hash

The default branch for ship-nix is `origin/main`. The **origin/** prefix sets the repo to a remote tracking branch.

It can also be set to simply `main`, but we recommend the origin prefix.

If your default branch is something else, like `master`, you must change to `origin/master`

#### Rollback to a certain commit

You can rollback your server configuration back in time by inputting a commit hash like `d07c66e` into the `Branch/commit hash` input. When you click `Deploy`, it will rollback to this earlier version.

This rollback will not directly do anything to your database (unless you have added something in the `before-rebuild` or `after-rebuild` script).

**Always test a rollback on a staging server before production to make sure it doesn't do something unintended**

### Build with --impure flag

You generally don't need to overthink this option too much. If you are able to deploy in without the `--impure` flag, then all is good, and this is generally the preferred way in NixOS.

Some configurations are impure, meaning for example that they require you connect to the internet.

For example IHP needs impure mode because of how their nix config is currently written.
