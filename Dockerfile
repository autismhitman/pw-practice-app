# Use a lightweight Node.js image
FROM node:18-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy package files first to leverage Docker cache
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the application (adjust if the script name differs in package.json)
RUN npm run build

# Install a simple server to host the static files
RUN npm install -g serve

# Expose the port the app runs on
EXPOSE 4200

# Start the application
CMD ["serve", "-s", "dist", "-l", "4200"]
