class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    if @event.save
      redirect_to events_path, notice: 'event was successfully created!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @event.update(event_params)

    redirect_to event_path(@event)
  end

  def destroy
    @event.destroy

    redirect_to events_path, status: :see_other
  end

  private

  def event_params
    params.require(:event).permit(:name, :date, :time, :location)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
