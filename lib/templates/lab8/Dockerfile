FROM dart:stable AS build

WORKDIR /app
COPY pubspec.yaml pubspec.lock ./
RUN dart pub get

COPY . .

RUN flutter build web --release

EXPOSE 8080

CMD ["flutter", "run", "-d", "chrome", "--web-port=8080"]
