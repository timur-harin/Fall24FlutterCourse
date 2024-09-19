FROM dart:stable AS build

WORKDIR /app

COPY . .

RUN flutter pub get

RUN flutter build web

FROM nginx:stable

COPY --from=build /app/build/web /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
