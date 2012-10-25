require 'httparty'
require 'json'

class RsvpGetter

  def initialize api_key
    @api_key = api_key
  end

  def get event_id
    response = HTTParty.get("https://api.meetup.com/2/rsvps?key=#{@api_key}&event_id=#{event_id}")
    hash = JSON.parse response.body

    # attach success? & results methods to just the Hash result - e.g. meta programming

    def hash.success?
      self.has_key? "results"
    end

    def hash.results
      self["results"]
    end

    hash
  end
end

