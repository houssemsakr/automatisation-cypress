# Stage 1: Compile and Build Angular Codebase
FROM node:latest as build

# Set the working directory inside the container
WORKDIR /usr/local/app

# Copy package.json and package-lock.json to the working directory
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Install Angular CLI globally
RUN npm install -g @angular/cli

# Copy the rest of the application code to the working directory
COPY . .

# Build the application for production
RUN npm run build -- --output-path=./dist/out

# Stage 2: Serve the application with Nginx server
FROM nginx:latest

# Copy the build output to Nginx HTML directory
COPY --from=build /usr/local/app/dist/out /usr/share/nginx/html

# Copy custom Nginx configuration file
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80 to the outside world
EXPOSE 80
