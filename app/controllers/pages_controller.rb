class PagesController < ApplicationController
  def home
    @events = Event.all.order(date: :asc) # Fetch all events and sort them by date

    # Group events by year and then by month
    @events_by_year = @events.group_by { |event| event.date.year }.transform_values do |events|
      events.group_by { |event| event.date.month }
    end

    # List of months for display
    @months = Date::MONTHNAMES.compact
  end

  def about
  end

  def contact
  end
  
  def cgu
  end
end