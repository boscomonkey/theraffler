class MeetupEvent < ActiveRecord::Base
  attr_accessible :identifier

  def to_url
    "http://www.sfruby.info/events/#{self.identifier}"
  end
end
