---
title: Git
layout: "base.njk"
eleventyNavigation:
  key: Git
  title: Git
  parent: Servers
  order: 2
---

## Enabling unsupported Git provider on your server

By default, ship-nix adds verified ssh fingerprints for **Github, Gitlab and BitBucket** into the `~/.ssh/known_hosts` file when bootstrapping your server. These providers can therefore be used out of the box without any additional setup.

ship-nix does not auto-accept unknown hosts into `known_hosts` on your behalf. Doing so would open up your servers for MITM (meddler/man-in-the-middle) attacks.

Therefore, if you wish to add a less known git provider, for example your self-hosted one, you need to add the keys for this provider to your `known_hosts` file yourself.

### The proper way

Adding your keys according to best practices is a minor hassle, but vital for making sure that you do it in a secure way.

#### 1. Find ssh fingerprints from authorative source

Ideally, you should be able find the SSH keys for your git provider somewhere on their website.

Github, for example has a they have posted their SSH [key fingerprints here](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/githubs-ssh-key-fingerprints) for you to validate.

#### 2. Run a keyscan and see if keys matches

SSH into your server.

```bash
ssh ship@your.server.host
```

Find the equivalent page for your git provider. You should then verify that the fingerprints are similar to when you run this command

```bash
ssh-keyscan yourgitprovider.com | ssh-keygen -lf -
```

You will get a result like this.

```bash
$ ssh-keyscan yourgitprovider.com | ssh-keygen -lf -
2048 SHA256:[somefingerprint] yourgitprovider.com (RSA)
256 SHA256:[somefingerprint] yourgitprovider.com (ECDSA)
256 SHA256:[somefingerprint] yourgitprovider.com (ED25519)
```

If the keys are similar to the keys officially listed on the git provider site, you copy the output from the keyscan to the bottom of your `~/.ssh/known_hosts` file, for example with `vim` or `nano`.

## Easy, but not recommended way

We mention this method so you can remember to avoid it.

Since this method is often an answer on Stack Overflow, we should mention that you could do also enable your provider with a simple one-liner like this:

```bash
# Not recommended
ssh-keyscan github.com >> ~/.ssh/known_hosts
```

It automatically pastes the result of ssh-keyscan into your `known_hosts` file. Use this with great care!

This will enable your git provider the same way, but also opens up the opportunity for a MITM attack.

So in conclusion this one-liner is unsafe and your should go with the more tedious **proper way** for your servers.
