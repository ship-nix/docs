---
title: Domain names
layout: "base.njk"
eleventyNavigation:
  key: AddDomain
  title: Domain names
  parent: Servers
  order: 5
---

Pointing to domains is {{site.name}} is done via the NixOS configuration.

## First, point the domain to the server.

You can add an A record to the `public IP` on your server.

If you manage your domain via DigitalOcean, you can automatically find your droplet.

<a target="_blank" href="/images/digitalocean-domain-record.webp"><img src="/images/digitalocean-domain-record.webp" /></a>

Otherwise, just for example point an `A` record with the domain or subdomain you want to the public IP found on your server dashboard.

- [Read all about domains and DNS on DigitalOcean](https://docs.digitalocean.com/products/networking/dns/)

## Declare the domain in the NixOS configuration

Here is a code snippet that contains `nginx` configuration.

Look for `services.nginx.virtualHosts` in your NixOS configuration and replace `"localhost"` key in this example to your domain like this:

```diff-nix
# ...
  services.nginx.virtualHosts = {
-   "localhost" = {
+   "yourdomain.com" = {
      serverAliases = [];
      enableACME = httpsEnabled;
      forceSSL = httpsEnabled;
      locations = {
        "/" = {
          proxyPass = "http://localhost:8000";
          proxyWebsockets = true;
          extraConfig =
            "proxy_ssl_server_name on; proxy_pass_header Authorization;"
          ;
        };
      };
    };
  };
#...
```

You can also add more A records and add them to `serverAliases` options.

```diff-nix
# ...
  services.nginx.virtualHosts = {
    "yourdomain.com" = {
-     serverAliases = [  ];
+     serverAliases = [ "www.yourdomain.com" "sub.anotherdomain.com" "exampledomain.com" ];
      enableACME = httpsEnabled;
      forceSSL = httpsEnabled;
      locations = {
        "/" = {
          proxyPass = "http://localhost:8000";
          proxyWebsockets = true;
          extraConfig =
            "proxy_ssl_server_name on; proxy_pass_header Authorization;"
          ;
        };
      };
    };
  };
#...
```

- [Read more about these configuration options on NixOS.org](https://search.NixOS.org/options?show=services.nginx.virtualHosts)

## Deploy

After making the changes in `configuration.nix`, push and deploy.

**Be prepared that it can take around 24-48 hours (usually less) for the domain name to propagate.**

## Next steps

After your domain has propagated, you should also add https with `LetsEncrypt`.

- [Read more in the https/LetsEncrypt section](/servers/https/)
