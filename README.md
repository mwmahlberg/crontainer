crontainer
==========

[![GitHub](https://img.shields.io/github/license/mwmahlberg/crontainer)](https://raw.githubusercontent.com/mwmahlberg/crontainer/master/LICENSE) [![Docker Image Version (latest semver)](https://img.shields.io/docker/v/mwmahlberg/crontainer?label=docker%20image&sort=semver)](https://hub.docker.com/repository/docker/mwmahlberg/crontainer/tags?page=1&ordering=last_updated) ![Docker Image Size (latest semver)](https://img.shields.io/docker/image-size/mwmahlberg/crontainer?sort=semver) ![Docker Pulls](https://img.shields.io/docker/pulls/mwmahlberg/crontainer) ![GitHub last commit](https://img.shields.io/github/last-commit/mwmahlberg/crontainer)

A simple container running cronjobs.

It is meant to be used as a base image for your cron jobs.

Furthermore, it uses [dockerize][dockerize] to process your crontab files as templates.

Usage
-----

Simply use this image as a base image.

### Create a cronfile

The user under which the cron jobs are executed is names `cronrunner` and the cron file needs to be named accordingly.

```shell
$ echo "*/1     *       *       *       *       /usr/local/bin/myexecutable" > cronrunner.crontab
```

### Create your custom image

1. Create your Dockerfile

      ```dockerfile
      FROM mwmahlberg/crontainer
      COPY cronrunner.crontab /cron.d/cronrunner
      COPY myexecutable /usr/local/bin/
      ```

2. Build your image

       $ docker build -t your/cronrunner .
       [...]
       Successfully tagged your/cronrunner:latest

3. Run your image as usual

       $ docker run --name dostuff -d your/cronrunner
       dostuff

On cron files
------------

The files that tell the cron daemon what to do and when are called cron files.
They consist of a cron expressions and a command to execute per line.

    * * * * * command to execute
    - - - - -
    | | | | |
    | | | | ----- Day of week (0 - 6) (Sunday =0)
    | | | ------- Month (1 - 12)
    | | --------- Day (1 - 31)
    | ----------- Hour (0 - 23)
    ------------- Minute (0 - 59)

Further reading:

* [man 5 crontab](https://linux.die.net/man/5/crontab)

License
-------

Copyright 2020 Markus W Mahlberg

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[dockerize]: https://github.com/jwilder/dockerize
