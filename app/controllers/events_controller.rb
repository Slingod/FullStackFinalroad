class EventsController < ApplicationController
  def index
    @events_by_year = {}

    (2021..2026).each do |year|
      events = Event.where(date: Date.new(year, 1, 1)..Date.new(year, 12, 31))
      months = events.group_by { |event| event.date.month }
      @events_by_year[year] = months
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new  # Initializing the @event object
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to @event, notice: "Event successfully created!"
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id]) 
  end

  def update
    @event = Event.find(params[:id])
    
    if @event.update(event_params)
      redirect_to @event, notice: 'The event has been successfully modified.'
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path, notice: "Event successfully deleted."
  end

  private

  
  def event_params
    params.require(:event).permit(:author, :title ,:location, :picture, :duration, :price, :date)
  end
end
