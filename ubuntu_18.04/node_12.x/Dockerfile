FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y curl

RUN curl -fsSL https://deb.nodesource.com/setup_12.x | bash && \ 
    apt-get install -y nodejs && \
    node -v && npm -v

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*
