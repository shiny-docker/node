FROM node:4.1.2-slim

RUN \
  apt-get update && \
  apt-get install -y git

EXPOSE 80
EXPOSE 443

ENV NODE_ENV CI
ENV PATH $PATH:/var/www/node_modules/.bin

CMD ["authbind", "--deep", "npm", "start"]
