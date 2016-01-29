#!/usr/bin/env ruby

# import RubyGems
require 'bundler'
Bundler.require

# import My libs
require_relative 'lib/doorkeeper.rb'
require_relative 'lib/botUtil.rb'

# load ENV from .env file
Dotenv.load ".env"
SAVEFILE= ENV["savefile"] || "savedEvents.yml"

# load saved events data
savedEvents = BotUtil.loadYmlData(SAVEFILE)
p savedEvents

# main Script
data = ""
DoorKeeper.getGroupEvents(ENV["group"]).each do | event |
  eventData = event["event"]
  eventData.delete("description")
  data << eventData.to_yaml
end

# save events data
BotUtil.saveYmlData(SAVEFILE,data)
