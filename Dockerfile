# Use the latest Ubuntu as the base image
FROM ubuntu:latest

# Install Dart SDK dependencies
RUN apt-get update && \
    apt-get install -y \
    curl \
    apt-transport-https \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Install the Dart SDK
RUN curl -fsSL https://dl-ssl.google.com/linux/linux_signing_key.pub | gpg --dearmor > /usr/share/keyrings/dart-archive-keyring.gpg && \
    sh -c 'echo "deb [signed-by=/usr/share/keyrings/dart-archive-keyring.gpg] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main" > /etc/apt/sources.list.d/dart_stable.list' && \
    apt-get update && \
    apt-get install -y dart

# Set the working directory
WORKDIR /lib/templates/lab8

# Copy pubspec and install dependencies
COPY pubspec.* ./
RUN dart pub get

# Copy the rest of the application code
COPY . .

# Compile the Dart application
RUN dart compile exe bin/server.dart -o bin/server

# Expose the desired port (e.g., 8080)
EXPOSE 8080

# Run the application
CMD ["./bin/server"]
