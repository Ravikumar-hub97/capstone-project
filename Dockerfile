# Use Node base image
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Install required dependencies
RUN apk add --no-cache python3 make g++

# Copy application code
COPY . .

# Install dependencies
RUN npm install

# Build the app
RUN npm run build

# Install serve to run the production build
RUN npm install -g serve

# Expose port 80
EXPOSE 80

# Command to run the app
CMD ["serve", "-s", "build", "-l", "80"]
