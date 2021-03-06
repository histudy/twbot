#!/usr/bin/env ruby

# import RubyGems
require 'yaml'
require 'open-uri'
require 'bundler'
Bundler.require

# import My libs
require_relative 'lib/doorkeeper.rb'
require_relative 'lib/botUtilDoorkeeper.rb'

# load ENV from .env file
Dotenv.load ".env"
SAVEFILE= ENV["savefile"] || "savedEvents.yml"

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

# Load saved events
saved_events = BotUtil.loadYmlData(SAVEFILE,false)
saved_id = saved_events.map{|item| item["id"]}

# Main Test Scripts
DoorKeeper.getGroupEvents(ENV["group"]).each do | event |
  # Event data setting
  event = event["event"]
  output = BotUtil.tweetMsg(event,hashtags,random_messages)

  # Output section
  bot.update(output)
  sleep(1)
end

# today event
saved_events.each do | event |
  if saved_id.include?(event["id"]) and BotUtil.compDates(event["starts_at"]) == 0
    message = BotUtil.tweetMsg(event,hashtags,random_messages)
    bot.update(message)
    sleep(2)
  end
end
