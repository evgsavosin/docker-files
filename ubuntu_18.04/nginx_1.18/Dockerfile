FROM ubuntu:18.04

# Add user
RUN groupadd -r nginx && \
    useradd -r -g nginx nginx

# Base installation
RUN apt-get update && \
    apt-get install -y software-properties-common

# Install nginx stable version
RUN add-apt-repository -y ppa:nginx/stable && \
    apt-get update && \
    apt-get install -y nginx

# Change owner to nginx directories
RUN chown -R nginx:nginx /etc/nginx && \
    chown -R nginx:nginx /var/www && \
    chown -R nginx:nginx /var/log/nginx && \
    chmod -R 777 /var/www
 
# Clean
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]