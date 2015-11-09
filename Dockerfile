FROM node:4.1.2-slim

RUN \
  npm install -g forever nodemon grunt-cli node-inspector mocha bower

EXPOSE 80
EXPOSE 443

ENV NODE_ENV production

CMD ["/run.sh"]
