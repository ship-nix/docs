---
title: SSH access
layout: "base.njk"
eleventyNavigation:
  key: SSH
  title: SSH access
  parent: Servers
  order: 5
---

SSH, ([Secure Shell](https://www.ssh.com/academy/ssh)) access gives you secure remote access to the system shell of your server.

Depending on the complexity of your project, you might or might not use SSH much.

## SSH security

As you transition into the world of self-managed NixOS servers with secrets and databases with customer data, you need to prioritize SSH key security.

<div class="not-prose bg-blue-100 rounded-lg py-5 px-6 mb-4 text-base text-blue-700 mb-3 space-y-4" role="alert">
  <p>The most important message on this page is: <strong>SECURE YOUR SSH KEYS</strong>. And make it mandatory for every system admin of your servers.</p>

<p><strong>Why?</strong> If an attacker get access to your laptop and your SSH keys are passwordless, they can access your source code, your customer data and secrets within seconds.</p>

</div>

Your SSH keys live in your `/home/ship/.ssh` folder on your server.

### Password protect SSH key

A password that you remember, but is hard to crack is vital.

Consider **password protecting ALL your SSH keys**. Having one passwordless key with access vital services can undermine your secure keys.

Github has a simple guide on [working with SSH key passphrases](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/working-with-ssh-key-passphrases?platform=mac)

#### Pros

- No need to bring anything. Password is stored in your head.

#### Cons

- Strong password are hard to remember and tedious to write

### Hardware key (Yubikey)

You can generate SSH keys directly on a hardware security key like Yubikey, giving you physical SSH keys.

ship-nix will also eventually support [WebAuthn](https://en.wikipedia.org/wiki/WebAuthn) hardware key support on the web dashboard.

There are several alternatives if you want to use SSH keys on a hardware key.

- [yubikey-agent (currently used by ship-nix)](https://nixos.wiki/wiki/Yubikey)
- [xeiaso.net: How to Store an SSH Key on a Yubikey (you just need OpenSSH 8.2+)](https://xeiaso.net/blog/yubikey-ssh-key-storage)
- [NixOS wiki has an article about Yubikey](https://nixos.wiki/wiki/Yubikey)

#### Pros

- Bring your physical SSH key to any computer
- Enhances security on many services (soon ship-nix too)

#### Cons

- The hardware keys costs a bit to purchase, and you might want a spare key
- If you use `yubikey-agent`, you must have this installed on every computer where you need to use your keys

## Connect to your server

Connecting via SSH to your server is simple as:

```bash
ssh ship@youripaddress
```

If you have a domain set up, you can use this instead of your IP address:

```bash
ssh ship@yourdomain.com
```

## Add SSH keys on DigitalOcean

Uploading your SSH keys on DigitalOcean is a time-saver because you can select to add them to the server when you create a new server from ship-nix.

<img src="/images/do-ssh-keys.webp" />

- [digitalocean.com: How-to Add SSH Keys to New or Existing Droplets](https://docs.digitalocean.com/products/droplets/how-to/add-ssh-keys/)

## Give and revoke SSH access to server

You can manage who gets to access your server by removing and adding SSH public keys to the `/nixos/authorized_hosts` file in your project repository.

It's possible to move `authorized_hosts` out of version control, but we do not recommend it as this complicates your setup and doing something wrong here can lock you **permanently** out of your server.

If you want users to access the source code, but **not** the server, a better way would be to keep NixOS configuration and application separate and only give developer access to the application code.

## Troubleshooting

### ERROR: publickey denied

If you get an error message saying your public key is denied, it means that the computer your are trying to connect from is not authorized by your NixOS server.

To authorize your computer, you need to locate your **public** ssh key in your `~/.ssh` folder.

```bash
cat ~/.ssh/id_rsa.pub
```

Then append the contents of the public key file to your `server-config/authorized_keys` file in your project.

If you want this computer to access all new servers, you can add your SSH key to your DigitalOcean account. Then, each time you create a new server with ship Nix, you can simply select to include the SSH key automatically.

Read the DigitalOcean docs about how to add SSH keys

- [How-to Add SSH Keys to New or Existing Droplets (digitalocean.com)](https://docs.digitalocean.com/products/droplets/how-to/add-ssh-keys/)
