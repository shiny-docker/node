FROM node:4.1.2-slim

COPY run.sh /run.sh
#install node dependencies
#allow node user to run services on port 80 and 443 (when prefixed with 'authbind')
RUN \
  npm install -g forever nodemon grunt-cli node-inspector mocha bower && \
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
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
  chmod +x /run.sh

WORKDIR /var/www/

EXPOSE 80
EXPOSE 443

USER node

ENV NODE_ENV production
ENV PATH $PATH:/var/www/node_modules/.bin

ENTRYPOINT ["authbind", "--deep"]
CMD ["npm", "start"]
