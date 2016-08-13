#!/usr/bin/env ruby

# import RubyGems
require 'bundler'
Bundler.require

# import My libs
require_relative 'lib/connpass.rb'
require_relative 'lib/botUtilConnpass.rb'

# load ENV from .env file
Dotenv.load ".env"
SAVEFILE= ENV["savefile"] || "savedEvents.yml"

# load saved events data
savedEvents = BotUtil.loadYmlData(SAVEFILE)

# main Script
data = ""
Connpass.getGroupEvents(ENV["group"])["events"].each do | event |
  eventData = event
  eventData.delete("description")
  data << eventData.to_yaml
end

# save events data
BotUtil.saveYmlData(SAVEFILE,data)
