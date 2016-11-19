require 'open-uri'
require 'json'

API = "https://connpass.com/api/v1/event/"

class Connpass
  class << self
    public
    def getGroupEvents(group,sort=nil)
      query = "#{API}?series_id=#{group}"
      unless sort.nil?
        query = "#{query}&sort=#{sort}"
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
