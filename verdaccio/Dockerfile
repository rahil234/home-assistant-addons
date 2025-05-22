FROM node:18-alpine

RUN npm install -g verdaccio

COPY run.sh /run.sh
COPY config.yaml /config.yaml

RUN chmod +x /run.sh

CMD [ "/run.sh" ]