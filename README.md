# mini-piwik

A minimal Docker image based on [docker-mini-php](https://github.com/sseemayer/docker-mini-php) for [Piwik](https://piwik.org) designed for comfortable deploying on [Dokku](http://dokku.viewdocs.io/dokku/). Contains the GeoLite data created by MaxMind, available from http://www.maxmind.com.


## Running in dokku

Requires a linked MySQL or MariaDB database (in dokku, use the official mariadb plugin). 

```
dokku apps:create piwik
sudo mkdir -p ~dokku/piwik/persistent-data
dokku docker-options:add piwik deploy --volume /home/dokku/piwik/persistent-data:/app/htdocs/config
dokku docker-options:add piwik run --volume /home/dokku/piwik/persistent-data:/app/htdocs/config
dokku mariadb:create piwik-db
dokku mariadb:link piwik-db piwik
```

Then push the contents of this repository to your dokku git endpoint. When configuring the database, use the following settings:

**Database Hostname:** `dokku-mariadb-piwik-db`
**Database Username:** `mariadb`
**Database Password:** (use `dokku mariadb:info piwik-db` to query database information. Your password is between `mariadb:` and `@dokku-mariadb-piwik-db` in the `DSN:` string.)
**Database Name:** `piwik-db`

You can use [dokku-letsencrypt](https://github.com/dokku/dokku-letsencrypt) to enable HTTPS so that statistics for HTTPS websites can be gathered.
