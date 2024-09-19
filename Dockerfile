FROM ubuntu:latest AS build

RUN apt-get update && apt-get install -y \
    curl \
    git \
    xz-utils \
    zip \
    unzip \
    libglu1-mesa && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV FLUTTER_VERSION=3.13.7

RUN git clone https://github.com/flutter/flutter.git /flutter
ENV PATH="/flutter/bin:/flutter/bin/cache/dart-sdk/bin:${PATH}"
RUN flutter channel stable
RUN flutter upgrade
RUN flutter config --enable-web

WORKDIR /app

COPY pubspec.* ./
RUN flutter pub get

COPY . .

RUN flutter build web --release

FROM nginx:alpine

COPY --from=build /app/build/web /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
