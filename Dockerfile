# Используем последний образ Ubuntu в качестве базового
FROM ubuntu:latest

# Устанавливаем переменную окружения для неинтерактивной установки
ENV DEBIAN_FRONTEND=noninteractive

# Устанавливаем необходимые зависимости
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa

# Клонируем Flutter SDK из репозитория
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter -b stable --depth 1

# Добавляем Flutter в PATH
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:$PATH"

# Обновляем PATH
RUN echo "export PATH=\$PATH:/usr/local/flutter/bin" >> ~/.bashrc

# Проверяем установку Flutter
RUN flutter doctor -v

# Устанавливаем рабочую директорию
WORKDIR /app/lib/templates/lab8

# Копируем файлы проекта в контейнер
COPY . /app/lib/templates/lab8

# Устанавливаем зависимости проекта
RUN flutter pub get

# Собираем проект (для веб-приложения)
RUN flutter build web

# Открываем порт 8080 для веб-приложения
EXPOSE 8080

# Запускаем приложение
CMD ["flutter", "run", "-d", "web-server", "--web-port", "8080", "--web-hostname", "0.0.0.0"]
