# Use the Nginx image from Docker Hub as the base image
FROM nginx:alpine

# Copy the index.html file into Nginx's serving directory
COPY . /usr/share/nginx/html

# Expose port 80 to allow communication to/from the server
EXPOSE 80

# Use the default command for Nginx (start serving)
CMD ["nginx", "-g", "daemon off;"]
