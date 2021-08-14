FROM ubuntu:18.04

# Base installation
RUN apt-get update && \
    apt-get install -y git && \
    apt-get install -y wget && \
    apt-get install -y autoconf && \
    apt-get install -y software-properties-common && \
    apt-get install -y build-essential libpcre3 libpcre3-dev libssl-dev && \
    apt-get install -y zlib1g zlib1g-dev
    
# Download nginx
RUN wget http://nginx.org/download/nginx-1.18.0.tar.gz && \
    tar -xf nginx-1.18.0.tar.gz

# Compile nginx
RUN cd nginx-1.18.0 && \
    git clone https://github.com/sergey-dryabzhinsky/nginx-rtmp-module.git && \
    ./configure \
    	--prefix=/usr/share/nginx \
    	--sbin-path=/usr/sbin/nginx \
    	--modules-path=/usr/lib/nginx/modules \
    	--conf-path=/etc/nginx/nginx.conf \
    	--error-log-path=/var/log/nginx/error.log \
    	--http-log-path=/var/log/nginx/access.log \
    	--pid-path=/run/nginx.pid \
    	--lock-path=/var/lock/nginx.lock \
    	--user=www-data \
    	--group=www-data \
    	--http-client-body-temp-path=/var/lib/nginx/body \
        --http-fastcgi-temp-path=/var/lib/nginx/fastcgi \
        --http-proxy-temp-path=/var/lib/nginx/proxy \
        --http-scgi-temp-path=/var/lib/nginx/scgi \
        --http-uwsgi-temp-path=/var/lib/nginx/uwsgi \
    	--with-http_ssl_module \
    	--with-debug \
    	--with-file-aio \
        --with-threads \
        --with-http_addition_module \
        --with-http_auth_request_module \
        --with-http_dav_module \
        --with-http_flv_module \
        --with-http_gunzip_module \
        --with-http_gzip_static_module \
        --with-http_mp4_module \
        --with-http_random_index_module \
        --with-http_realip_module \
        --with-http_slice_module \
        --with-http_ssl_module \
        --with-http_sub_module \
        --with-http_stub_status_module \
        --with-http_v2_module \
        --with-http_secure_link_module \
        --with-stream \
        --with-stream_realip_module \
        --with-stream_ssl_module \
        --with-stream_ssl_preread_module \
    	--add-module=nginx-rtmp-module && \            
    make -j 1 && \
    make install
    
# Install FFMPeg
RUN apt-get install -y ffmpeg
    
# Clean
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf nginx-1.18.0 && \
    rm nginx-1.18.0.tar.gz

RUN mkdir -p /var/lib/nginx

# Listen port
EXPOSE 80 443

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
