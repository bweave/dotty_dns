# DottyDNS

A Pi-hole inspired, Ruby and Rails powered DNS server and admin UI.

### Requirements

- Ruby 3+
- Redis
- Postgres 10+

### Usage

Setup the Rails app.
```
$ bin/setup
```

Start the DNS server.
```
$ bin/dns_server
```

Test out some queries. Adjust the port as needed.
```
$ dig @localhost -p 5300 google.com
```

Use the DNS server as your local computer's DNS by pointing your Network DNS setting at `127.0.0.1`.

Start the Rails admin app.
```
$ bin/dev
```

Access the Rails app at http://127.0.0.1:3000.
<img width="930" alt="dottydns-dashboard" src="https://github.com/bweave/dotty_dns/assets/6437945/d367bce5-96b1-463c-8d69-f84687a2b118">
