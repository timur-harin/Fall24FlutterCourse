FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y curl git unzip zip nginx

RUN git clone --single-branch --branch stable https://github.com/flutter/flutter.git  
RUN cd /flutter
ENV PATH "$PATH:/flutter/bin:/flutter/bin/cache/dart-sdk/bin"

# Enable flutter web
RUN flutter channel stable
RUN flutter upgrade
RUN flutter config --enable-web

COPY . /app
WORKDIR /app

RUN flutter pub get
RUN flutter build web --target=lib/templates/lab8/main.dart

# Copy the build files to nginx's serve directory
RUN cp -r build/web/* /var/www/html

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
