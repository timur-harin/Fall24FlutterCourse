FROM ubuntu:latest

# Install Flutter
RUN apt-get update && \
    apt-get install -y curl wget unzip && \
    curl -sL https://get.flutter.dev/docs/install/linux#install-from-the-archive | bash && \
    export PATH="$PATH:/usr/local/flutter/bin" && \
    flutter doctor

# Install dependencies
COPY pubspec.yaml .
COPY pubspec.lock .
RUN flutter pub get

# Build the web app
RUN flutter build web --web-renderer html --release --target=lib/templates/lab8/main.dart # Build target
