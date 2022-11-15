---
title: Create and destroy servers
layout: "base.njk"
eleventyNavigation:
  key: CreateAndDestroy
  title: Create and destroy
  parent: Servers
  order: 1
---

## Creating servers

There are different ways of creating a server, depending on what you want to do.

### 1. Create a new project

Creating a server from {{site.name}} is a great way to start a new project.

1. Select a starter template, pick your hardware specs and create
2. Follow the git guide in your server dashboard to create a new repo with deploy key from your server
3. Pull the code to your computer and start developing

### 2. Create a server based on an existing repository

There are two ways to add an existing project.

#### a. Import a {{site.name}} compatible project

You can create a [staging server](/servers/staging-servers) or maybe you have a personal starter template.

#### b. Import a non-{{site.name}} project

If you have a project that has not yet been deployed on {{site.name}}, you can choose to **"shipnixify"** your code.

{{site.name}} will generate a script you can run locally on your machine to make the necessary changes to your repository.

## Deleting servers

If you wish to delete your server, this can be done from the {{site.name}} dashboard under **Settings**.

There are two ways of deleting a server from {{site.name}}.

### Eject

Ejecting your server means simply that data about your server is erased from {{site.name}}. Your server will **still exist**, just not on {{site.name}}.

<div class="bg-blue-100 rounded-lg py-5 px-6 mb-4 text-base text-blue-700 mb-3" role="alert">
  To ensure you still have access to the server without {{site.name}}, be sure that you are able to log into your server with <a class="text-blue-700" href="/servers/ssh">SSH</a>.
</div>

### Destroy server

Destroying your server will wipe your server from DigitalOcean and {{site.name}}.
