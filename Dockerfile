FROM node:20-alpine

WORKDIR /app

COPY package.json ./
COPY package-lock.json ./
RUN npm install

# Install the CLI globally
RUN npm install -g @jungvonmatt/contentful-migrations

COPY . .
