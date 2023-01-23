---
title: PostgreSQL
layout: "base.njk"
eleventyNavigation:
  key: PostgreSQL
  title: PostgreSQL
  parent: Starters
  order: 5
---

The PostgreSQL starter is for bootstrapping a self-managed database server.

This starter does not have many instructions for how it should be used.

One possible usecase is to self-host the database without sharing resources with your app server.

It could also be a starting point for any type of application you want to use that depends on a postgresql database.

## Defaults

The default username is `shipadmin`.

The default database name is `defaultdb`.

The default password is automatically generated.

## Configuration resources

Some useful resources for configuring the Postgres starter to your wishes

- [NixOs options search](https://search.nixos.org/options?query=services.postgresql)
- [NixOS wiki on PostgreSQL](https://nixos.wiki/wiki/PostgreSQL)
