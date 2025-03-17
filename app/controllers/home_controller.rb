class HomeController < ApplicationController
    def index
    end
  
    def contact
    end
  
    def shop
      @pictures = Picture.all  
    end
  
    def show
      @picture = Picture.find(params[:id])  
    end
  
    def admin
    end
  end