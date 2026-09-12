FROM node:22.23-alpine

WORKDIR /logitechapp
COPY package*.json ./
RUN npm install
COPY . .
RUN npx prisma generate
EXPOSE 3000
CMD npx prisma migrate deploy && node index.js