---
title: https:// (SSL/TLS)
layout: "base.njk"
eleventyNavigation:
  key: SSL
  title: https:// (SSL/TLS)
  parent: Servers
  order: 3
---

Having your use the secure **https://** protocol is pretty much mandatory for any modern web service. This requires a SSL/TLS certificate.

This is easy to fix declaratively via your NixOs configuration.

## How to enable

Find your Nginx declaration (usually on `site.nix`).

If you use one of the starters that come with ship-nix, you will find the variable `httpsEnabled` at the top.

```
{ config, lib, pkgs, ... }:
let
  # TODO: Enable SSL/HTTPS when your domain records are hooked up
  # By enabling SSL, you accept the terms and conditions of LetsEncrypt
  httpsEnabled = false;
in
{
...
}
```

Change this to `true`, commit, push and click the `Deploy` button on your server dashboard.

- [Using ACME certificates in Nginx (NixOS manual)](https://nixos.org/manual/nixos/stable/#module-security-acme-nginx)

## When adding certificates fail

Your domain record must be fully propagated to point to your server. So the first job will be to [hook up your server with domain records](/servers/add-domain).

If you encounter a screen like this, it probably means your domain records are not yet fully propagated, but it doesn't hurt to double check your records.

```bash
warning: the following units failed: acme-your-project.com.service

[0;1;31m×[0m acme-your-project.com.service - Renew ACME certificate for your-project.com
     Loaded: loaded (]8;;file://your-project/etc/systemd/system/acme-your-project.com.service/etc/systemd/system/acme-your-project.com.service]8;;; enabled; vendor preset: enabled)
     Active: [0;1;31mfailed[0m (Result: exit-code) since Wed 2022-08-10 11:29:48 UTC; 117ms ago
TriggeredBy: [0;1;32m●[0m acme-your-project.com.timer
    Process: 164630 ExecStart=/nix/store/6cpwa4bfza8yddj9spzvmaj5zhd3n17i-unit-script-acme-your-project.com-start/bin/acme-your-project.com-start [0;1;31m(code=exited, status=10)[0m
   Main PID: 164630 (code=exited, status=10)
         IP: 54.3K in, 20.9K out
        CPU: 103ms

Aug 10 11:29:48 your-project acme-your-project.com-start[164635]: 2022/08/10 11:29:48 Could not obtain certificates:
Aug 10 11:29:48 your-project acme-your-project.com-start[164635]:         error: one or more domains had a problem:
```

Your NixOs configuration will fail. If that happens, just re-disable https and try to enable it a bit later.
