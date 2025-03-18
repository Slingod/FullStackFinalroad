class PagesController < ApplicationController
  def home
    @events = Event.all
    @events_by_year = @events.group_by { |event| event.date.year }
    @events_by_year.each do |year, events|
      @events_by_year[year] = events.group_by { |event| event.date.month }
    end
    @months = ["January", "February", "March", "April", "May", "June",
          "July", "August", "September", "October", "November", "December"]
  end

  def about
  end

  def contact
  end
  
  def cgu
  end
end


