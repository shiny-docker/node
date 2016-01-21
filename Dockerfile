FROM node:4.1.2-slim

#install node dependencies
#allow node user to run services on port 80 and 443 (when prefixed with 'authbind')
RUN \
  mkdir -p /var/www && \
  useradd -ms /sbin/nologin node && \
  chown -R node:node /var/www && \
  apt-get update && \
  apt-get install -y authbind git && \
  rm -rf /var/lib/apt/lists/* && \
  touch /etc/authbind/byport/443 && \
  touch /etc/authbind/byport/80 && \
  chown -R node:node /etc/authbind/byport/ && \
  chmod -R 755 /etc/authbind/byport/ && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /var/www/

EXPOSE 80
EXPOSE 443


ENV NODE_ENV production

#npm install might depend on more than just package.json (e.g. bower.json), so just copy everything
ONBUILD COPY ./ /var/www
ONBUILD USER root
ONBUILD RUN chown -R node:node /var/www

USER node
ONBUILD USER node

ONBUILD RUN cd /var/www; npm install --production

CMD ["authbind", "--deep", "npm", "start"]
