# Use a small web server image
FROM nginx:alpine

# Remove default nginx static files
RUN rm -rf /usr/share/nginx/html/*

# Copy your static site into nginx html folder
COPY . /usr/share/nginx/html

# Nginx listens on port 80 by default
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
