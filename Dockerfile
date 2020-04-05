FROM alpine:3
# Copyright 2020 Markus W Mahlberg
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

ENV DOCKERIZE_VERSION v0.6.1
COPY ["hello.sh","/usr/local/bin/hello"]
COPY ["cronrunner.crontab","/etc/crontabs/cronrunner"] 

RUN apk add --no-cache openssl && wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && chmod +x /usr/local/bin/hello \
    && adduser -D cronrunner \
    && rm /etc/crontabs/root
   
ENTRYPOINT [ "/usr/local/bin/dockerize","-template","/cron.d/cronrunner:/etc/crontabs/cronrunner","/bin/ash","-c","crond -f -l 6 -L /dev/stdout"]