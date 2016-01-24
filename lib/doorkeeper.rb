require 'open-uri'
require 'json'

API = "http://api.doorkeeper.jp/"

class DoorKeeper
  class << self
    public
    def getGroupEvents(group,sort=nil)
      query = "#{API}groups/#{group}/events"
      unless sort.nil?
        query = "#{query}?sort=#{sort}"
      end
      responce = open(query)
      code,message = responce.status
      if code == '200'
        result = JSON.parse(responce.read)
      else
        result = nil
        p message
      end
      return result
    end
  end
end