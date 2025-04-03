class Admin::EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin_or_superadmin
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.all
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to admin_event_path(@event), notice: "Événement créé avec succès"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to admin_event_path(@event), notice: "Événement mis à jour avec succès"
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to admin_events_path, notice: "Événement supprimé"
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :author, :location, :duration, :price, :date, pictures: [], videos: [])
  end

  def authorize_admin_or_superadmin
    redirect_to root_path, alert: "Accès refusé" unless current_user.admin? || current_user.super_admin?
  end
end