class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :rsvp]

  # GET /events
  def index
    @events = Event.where('end_date > ?', Time.now).order(start_date: :asc)
  end

  # GET /events/1
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to @event, notice: 'Event was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /events/1
  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy
    redirect_to events_url, notice: 'Event was successfully destroyed.'
  end

  # GET /events/1/rsvp
  def rsvp
    if event_params && event_params[:answer] && save_rsvp
      redirect_to event_path(@event), notice: 'Successfully responded ' \
        "#{event_params[:answer]} for this event"
    else
      redirect_to event_path(@event),
                  alert: 'Unable to save response'
    end
  end

  private

  def save_rsvp
    return false unless %w(Yes No Maybe).include? event_params[:answer]
    current_user.events_users
      .create(event: @event, answer: event_params[:answer])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def event_params
    return false unless params[:event]
    params.require(:event).permit(:location, :start_date, :end_date,
                                  :start_time, :end_time, :event_type, :details,
                                  :answer)
  end
end
