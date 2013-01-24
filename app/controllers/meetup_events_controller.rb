require 'rsvp_getter'

class MeetupEventsController < ApplicationController
  # GET /meetup_events
  # GET /meetup_events.json
  def index
    @meetup_events = MeetupEvent.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @meetup_events }
    end
  end

  # GET /meetup_events/1
  # GET /meetup_events/1.json
  def show
    @meetup_event = MeetupEvent.find(params[:id])

    if api_key = ENV["MEETUP_API_KEY"]
      getter = RsvpGetter.new api_key
      response = getter.get @meetup_event.identifier
      @rsvps = response.results.shuffle
      @event_name = @rsvps.first["event"]["name"]
    else
      @rsvps = []
      flash[:notice] = "ERROR: missing API key"
    end

    event_with_rsvps = @meetup_event.attributes.merge("rsvps" => @rsvps)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: event_with_rsvps }
      format.xml { render xml: event_with_rsvps }
    end
  end

  # GET /meetup_events/new
  # GET /meetup_events/new.json
  def new
    @meetup_event = MeetupEvent.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @meetup_event }
    end
  end

  # GET /meetup_events/1/edit
  def edit
    @meetup_event = MeetupEvent.find(params[:id])
  end

  # POST /meetup_events
  # POST /meetup_events.json
  def create
    @meetup_event = MeetupEvent.new(params[:meetup_event])

    respond_to do |format|
      if @meetup_event.save
        format.html { redirect_to @meetup_event, notice: 'Meetup event was successfully created.' }
        format.json { render json: @meetup_event, status: :created, location: @meetup_event }
      else
        format.html { render action: "new" }
        format.json { render json: @meetup_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /meetup_events/1
  # PUT /meetup_events/1.json
  def update
    @meetup_event = MeetupEvent.find(params[:id])

    respond_to do |format|
      if @meetup_event.update_attributes(params[:meetup_event])
        format.html { redirect_to @meetup_event, notice: 'Meetup event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @meetup_event.errors, status: :unprocessable_entity }
      end
    end
  end
end
