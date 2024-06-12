require 'logger'

$stdout.sync = true
logger = Logger.new(STDOUT)
logger.level = Logger::INFO
logger.info("Script is running...")

dice_faces = ["🎲 1", "🎲 2", "🎲 3", "🎲 4", "🎲 5", "🎲 6"]

loop do
  logger.info("The dice rolled: #{dice_faces.sample}")
  sleep 5
end