Symfony Docker Edition
======================

The idea is to get up and running [Symfony][1] app, while keeping your machine clean. 
You only need to have few packages installed to achieve this: git, docker and docker-compose.

> Mac and Windows users also require either docker-machine or docker for Mac.

Up and running
--------------

> Make sure you have [Docker][2] and [Docker Compose][3] properly set up in your environment. 

Clone the repository

```bash
$ git clone git@github.com:madman/sy2docker.git
```

or

```bash
composer create-project --no-install --no-scripts madman/sy2docker
```
  
Manage files and folders access attributes

```bash
$ bin/init
```

Build images

```bash
$ docker-compose build
```

Run containers

```bash
$ docker-compose up -d
```

Install symfony dependencies

```bash
$ docker-compose run composer install 
```

Open [http://localhost:8080/](http://localhost:8080/) in your browser to enjoy the results.


What's included?
----------------

  * nginx - 1.10.1
  * fpm - php-fpm (php version is 5.6.30)
  * mysql - 5.5
  * composer - service to work with composer
  * console - symfony console

What differs from [Symfony Standard Edition][4]?
------------------------------------------------

  * removed SwiftmailerBundle package
  * removed incenteev/composer-parameter-handler. All things are configured automatically.

Licensing
---------
Symfony Docker Edition is licensed under MIT or BSD licenses. See [LICENSE][5] for the full license text.

Enjoy!

[1]:  https://symfony.com/doc/3.2/setup.html
[2]:  https://docs.docker.com/engine/installation/
[3]:  https://docs.docker.com/compose/install/
[4]:  https://github.com/symfony/symfony-standard
[5]:  https://github.com/madman/sy2docker/blob/master/LICENSE
