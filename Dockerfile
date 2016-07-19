FROM node:6.3.0-slim

#install node dependencies
#allow node user to run services on port 80 and 443 (when prefixed with 'authbind')
RUN \
  npm install -g npm && \
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

USER node

ENV NODE_ENV production
ENV PATH /var/www/node_modules/.bin:$PATH

ENTRYPOINT ["authbind", "--deep"]
CMD ["npm", "start"]
