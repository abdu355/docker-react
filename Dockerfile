# first block - build phase
FROM node:alpine as builder 

ENV NODE_ENV production
WORKDIR /app
COPY ["package.json", "."]
RUN npm install --production
COPY . .
RUN npm run build 

# new block - run phase
FROM nginx 
COPY --from=builder /app/build /usr/share/nginx/html
# nginx will start up by default