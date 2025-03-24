require 'net/http'
require 'json'

class WeatherController < ApplicationController
  before_action :authenticate_user!

  def show
    latitude = 48.917
    longitude = 2.252

    url = URI("https://api.open-meteo.com/v1/forecast?latitude=#{latitude}&longitude=#{longitude}&current_weather=true")
    response = Net::HTTP.get(url)
    @weather_data = JSON.parse(response)
  end
end
