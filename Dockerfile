FROM node:14

COPY server.js /usr/src/server

EXPOSE 8080 

CMD ["node", "server.js"]
