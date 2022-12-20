---
title: Mastodon
layout: "base.njk"
eleventyNavigation:
  key: Mastodon
  title: Mastodon
  parent: Starters
  order: 4
---

The `Mastodon` starter is a very simple starter, but also a quick way to provision your own Mastodon instance on NixOS.

## Add domain record

Adding a domain to your Mastodon instance is necessary.

As soon as you have gotten an IP address assigned to your server, add an A record from for example `social.yourdomain.com`, `mymastodoncommunity.com` and point it to the IP address of your server.

On DigitalOcean, it looks like this:

<img src="/images/mastodon-domain-record.webp" />

## Shipnixify a project without {{site.name}} config

In your repository, go to `nixos/configuration.nix`, find the `let in` statement at the top.

Fill in your mastodon domain name to the `mastodonDomain` option and set it corresponding to the domain name you have added in the previous step.

Also, set the `enableHttps` option to `true`.

```nix
let
  enableHttps = false;
  mastodonDomain = "social.yourdomain.com";
in
```

Commit and push the changes, then click `Deploy` in the dashboard for your server in {{site.name}}.

If it fails, it's because your DNS record has not propagated yet. Just give it some time and try again.

## Add yourself as an admin user

Next, you must ssh into your mastodon server.

```sh
ssh ship@youripaddress.com
```

Inside the shell of your server, you can add yourself as a user with owner permissions.

```
mastodon-env tootctl accounts create yourmastodonusername --email you@youremail.com --confirmed --role Owner
```

After the command has succeeded, a generated password will be displayed.

Log in with your email and the generated password. Change the password if you want and start managing your new mastodon instance.

For full documentation on the Mastodon admin cli, refer to the <a href="https://docs.joinmastodon.org/admin/tootctl/" target="_blank">Mastodon official docs</a>.

You can access all of these commands from the shell of your server by prefixing with `mastodon-env` before the command.

## For wider communities, add SMTP settings

If you want to host the instance for a wider community, you should also set up the SMTP settings.

This is needed for the Mastodon instance to communicate with your users via email for confirmation mail etc.

- <a href="https://search.nixos.org/options?query=services.mastodon.smtp">Refer to the Nixos options search for the relevant SMTP settings</a>
