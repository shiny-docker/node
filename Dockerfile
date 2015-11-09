FROM node:4.1.2-slim

RUN \
  npm install -g forever nodemon grunt-cli node-inspector mocha bower

RUN \
  apt-get update && \
  apt-get install -y git

EXPOSE 80
EXPOSE 443

ENV NODE_ENV build

CMD ["/run.sh"]
