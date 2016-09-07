FROM node:6.3.1-slim

RUN \
  apt-get update && \
  apt-get install -y git

EXPOSE 80
EXPOSE 443

ENV NODE_ENV CI
ENV PATH /var/www/node_modules/.bin:$PATH

CMD ["npm", "start"]
