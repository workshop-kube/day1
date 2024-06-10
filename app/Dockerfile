ARG RUBY_VERSION=3.3.1-jemalloc
FROM quay.io/evl.ms/fullstaq-ruby:${RUBY_VERSION}-slim

# Устанавливаем переменную окружения для рабочего каталога приложения
ENV APP_HOME /app

# Создаем рабочий каталог
RUN mkdir $APP_HOME

# Устанавливаем рабочую директорию для всех последующих команд
WORKDIR $APP_HOME

# Копируем файлы Gemfile и Gemfile.lock в рабочую директорию
COPY Gemfile Gemfile.lock ./

# Устанавливаем зависимости, указанные в Gemfile
RUN bundle install

# Копируем все остальные файлы приложения в рабочую директорию
COPY . .

# Открываем порт 9292 для доступа к приложению извне
EXPOSE 9292

# Определяем команду для запуска приложения
#CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0"]