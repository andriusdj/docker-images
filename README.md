# docker-images
Docker images:

WIP: not ready for production!

## PHP

Base OS: 
 - Debian v11.

PHP versions
 - 5.6
 - 7.4
 - 8.0
 - 8.1

Composer versions:
 - 1.x
 - 2.x
 
Images:
 - Production: minimal set of dependencies
 - Build: production + tools needed to build projects - composer, nodejs/npm, yarn
 - Dev: build + tools for debugging applications. Has Phabricator Arcanist support

Docker images tagged by php version and composer version, e.g. 
A development image having PHP v8.1 and Composer v2.x is tagged earthian/php-dev:8.1-2

TODO: clean up production and build images, adjust configs for production use (now all is the same!)

## NodeJS / Frontend projects
tbc

### ->>> Pull requests are welcome. <<<-