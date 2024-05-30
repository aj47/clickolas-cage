FROM node:21

WORKDIR /app

COPY . /app

RUN npm install 

CMD npm run dev
