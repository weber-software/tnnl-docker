FROM node:alpine

RUN npm install -g tnnl

CMD [ "tnnl" ]
