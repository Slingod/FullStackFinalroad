class PagesController < ApplicationController
  # Skip authentication for the home action
  skip_before_action :authenticate_user!, only: [:home, :about, :contact, :cgu, :events]

  def home
    @events = Event.order(date: :asc) # Trie les événements par date croissante
  
    # Trouver l'événement en cours (si la date d'aujourd'hui correspond)
    @current_event = @events.find { |event| event.date.to_date == Date.today }
  
    # Trouver le prochain événement (le premier après aujourd'hui)
    @next_event = @events.find { |event| event.date.to_date > Date.today }
  
    # Si un événement est en cours, on l'affiche en priorité
    @highlighted_event = @current_event || @next_event 
  
    # Groupement par année et mois
    @events_by_year = @events.group_by { |event| event.date.year }.transform_values do |events|
      events.group_by { |event| event.date.month }
    end
  end
  

  def events
    @events = Event.all.order(date: :asc)
  
    # Vérifier si on a des événements avant de grouper
    if @events.present?
      @events_by_year = @events.group_by { |event| event.date.year }.transform_values do |events|
        events.group_by { |event| event.date.month }
      end
    else
      @events_by_year = {}
    end
  end  

  def about
  end

  def contact
  end

  def cgu
  end
end