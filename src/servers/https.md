---
title: https:// (SSL)
layout: "base.njk"
eleventyNavigation:
  key: SSL
  title: https:// (SSL)
  parent: Servers
  order: 3
---

A web server is not fully shipped before https is added.

This is trivial to do on ship-nix, except from that builds will fail if domain name is not fully propagated, or there is something wrong with the domain records.
