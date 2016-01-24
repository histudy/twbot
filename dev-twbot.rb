#!env ruby

# import RubyGems
require 'yaml'
require 'open-uri'
require 'bundler'
Bundler.require

# import My libs
require_relative 'lib/doorkeeper.rb'
require_relative 'lib/botUtil.rb'

# load ENV from .env file
Dotenv.load ".env.dev"

# setup twitter bot
bot = Twitter::REST::Client.new(
  consumer_key: ENV["consumer_key"],
  consumer_secret: ENV["consumer_secret"],
  access_token: ENV["access_token"],
  access_token_secret: ENV["access_token_secret"]
)

# load event hash tags
hashtags = BotUtil.loadYmlData(ENV["hashtags"])

# load random messages
randomMessages = BotUtil.loadYmlData(ENV["randomMessages"])

# Main Test Scripts
DoorKeeper.getGroupEvents(ENV["group"]).each do | event |
  # Event data setting
  event = event["event"]
  start_time = Time.parse(event["starts_at"]).timezone
  end_time = Time.parse(event["ends_at"]).timezone
  period = "#{start_time.strftime("%Y/%m/%d %H:%M")} - #{end_time.strftime("%H:%M")}"
  reminder = BotUtil.compDates(start_time)
  hashtag = BotUtil.getHashtag(hashtags,event["title"])
  randomMessage = BotUtil.getRandomMessage(randomMessages,hashtag)

  # Formatting hashtag for twitter
  if hashtag != ""
    hashtag = "##{hashtag}"
  end

  # Output data setting
  output = "#{reminder} #{randomMessage}\n#{event["title"]}\n#{period}\n#{event["public_url"]}\n#{hashtag}"

  # Output section
#  bot.update(output)
#  sleep(1)
  puts event
  puts
end
