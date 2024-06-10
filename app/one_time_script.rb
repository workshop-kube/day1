require 'logger'

# Инициализация логгера, который будет выводить сообщения в STDOUT
logger = Logger.new(STDOUT)
logger.level = Logger::INFO

# Сообщение о начале работы скрипта
logger.info("One-time script is starting...")

# Основная логика скрипта (например, выполнение некоторых задач)
# В данном примере скрипт просто выводит сообщения в лог с некоторым интервалом
10.times do |i|
  logger.info("Working on task #{i + 1}...")
  sleep 2 # Симуляция работы, например, выполнение задачи занимает 2 секунды
end

# Сообщение о завершении работы скрипта
logger.info("One-time script has finished.")

# Завершение скрипта
exit