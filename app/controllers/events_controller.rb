class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:home, :index, :show]
  before_action :set_event, only: [:show, :edit, :update, :destroy, :toggle_participation]
  before_action :authorize_admin_or_superadmin, only: [:destroy]

  def home
    @events_by_year = Event.all.group_by { |event| event.date.year }
    @events_by_year.transform_values! do |months|
      months.group_by { |event| event.date.month }
            .transform_values do |events|
              events.map do |e|
                {
                  id: e.id,
                  author: e.author,
                  location: e.location,
                  pictures: e.pictures.map { |pic| url_for(pic) },
                  date: e.date.to_s,
                  duration: e.duration,
                  price: e.price
                }
              end
            end
    end
  end

  def index
    @events = Event.all
  end

  def show
    if @event
      @participant_count = @event.participants.count
    else
      redirect_to events_path, alert: "Event not found."
    end
  end

  def new
    @event = Event.new
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
    # Load event info for editing
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'The event has been successfully modified.'
    else
      render :edit
    end
  end

  def destroy
    if @event
      @event.destroy
      redirect_to root_path, notice: "Event successfully deleted."
    else
      redirect_to root_path, alert: "Event not found."
    end
  end

  def toggle_participation
    @event.toggle_participation(current_user)
    redirect_to @event, notice: "Your participation status has been updated."
  end

  private

  def set_event
    @event = Event.find_by(id: params[:id])
    redirect_to root_path, alert: "Event not found." unless @event
  end

  def event_params
    params.require(:event).permit(:author, :location, :duration, :price, :date, :title, pictures: [], videos: [])
  end

  def authorize_admin_or_superadmin
    # Ensure only admins or super-admins can delete events
    redirect_to root_path, alert: "Access Denied" unless current_user.admin? || current_user.super_admin?
  end
end
