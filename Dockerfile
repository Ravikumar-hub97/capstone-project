# Use an official Node.js image just to run the static server
FROM node:20-slim

# Install a static file server globally
RUN npm install -g serve

# Set the working directory
WORKDIR /app

# Copy your static files into the container
COPY . .

# Expose port 80
EXPOSE 80

# Serve the static files
CMD ["serve", "-s", ".", "-l", "80"]
