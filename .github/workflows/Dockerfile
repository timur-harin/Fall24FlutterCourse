FROM dart:stable AS build

WORKDIR /app

COPY pubspec.* ./

RUN dart pub get

COPY . .

RUN flutter build web --release

FROM nginx:alpine

COPY --from=build /app/build/web /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]