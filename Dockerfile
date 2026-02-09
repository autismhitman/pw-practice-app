# Stage 1: Build
FROM node:18-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build -- --configuration production

# Stage 2: Production Server
FROM nginx:stable-alpine
# The app builds into a subfolder in 'dist/'. 
# Ensure the path below matches the folder name inside your 'dist' folder.
COPY --from=build /app/dist/ /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
