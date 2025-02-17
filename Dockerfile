ARG NODE_VERSION=22.2.0

FROM node:${NODE_VERSION}

RUN apt-get update && apt-get install -y vim && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN useradd -m mynode

USER mynode

HEALTHCHECK --interval=10s --timeout=5s --start-period=5s --retries=3 CMD [ "curl", "-f", "http://localhost:3000" ]

CMD ["node", "index.js"]