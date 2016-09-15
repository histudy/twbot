#!/usr/bin/env ruby

# import RubyGems
require 'yaml'
require 'open-uri'
require 'bundler'
Bundler.require

# import My libs
require_relative 'lib/connpass.rb'
require_relative 'lib/botUtilConnpass.rb'

# load ENV from .env file
Dotenv.load ".env"

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
random_messages = BotUtil.loadYmlData(ENV["randomMessages"])

# Main Scripts
Connpass.getGroupEvents(ENV["group"])["events"].each do | event |
  # Check old events
  if BotUtil.compDates(event["started_at"]) >= 0
    # Event data setting
    output = BotUtil.tweetMsg(event,hashtags,random_messages)

    # Output section
    bot.update(output)
    sleep(1)
  end
end
