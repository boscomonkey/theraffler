require 'httparty'
require 'json'

describe RsvpGetter do

  before :each do
    api_key = ENV["MEETUP_API_KEY"]
    raise "need MEETUP_API_KEY environment variable" unless api_key

    @getter = RsvpGetter.new api_key
  end

  describe ".new" do
    it "should initialize with API key" do
      @getter.should_not be_nil
    end
  end

  describe "#get" do
    before :each do
      bookclub_event_id = "82560412"
      @rsvps = @getter.get(bookclub_event_id)
    end

    it "should return a Hash" do
      @rsvps.class.should == Hash
    end

    it "should return whether it is a success" do
      @rsvps.success?.should be_true
    end

    it "should return a hash with 'results' key array with 62 elements" do
      rsvp_arry = @rsvps.results
      rsvp_arry.class.should == Array
      rsvp_arry.size.should == 62
    end
  end

end

