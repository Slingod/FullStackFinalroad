class PicturesController < ApplicationController
    before_action :set_picture, only: [:show, :edit, :update, :destroy]
  
    # List of all pictures
    def index
      @pictures = Picture.all
    end
  
    # Displaying a specific picture
    def show
    end
  
    # Form to create a new picture
    def new
      @picture = Picture.new
    end
  
    # Creating a new picture
    def create
      @picture = Picture.new(picture_params)
      if @picture.save
        redirect_to @picture, notice: 'Picture was successfully created.'
      else
        render :new
      end
    end
  
    # Updating an existing picture
    def update
      if @picture.update(picture_params)
        redirect_to @picture, notice: 'Picture was successfully updated.'
      else
        render :edit
      end
    end
  
    # Deleting a picture
    def destroy
      @picture.destroy
      redirect_to pictures_url, notice: 'Picture was successfully destroyed.'
    end
  
    private
  
    # Method to find a picture by its ID
    def set_picture
      @picture = Picture.find(params[:id])
    end
  
    # Method to set allowed parameters for CRUD actions
    def picture_params
      params.require(:picture).permit(:name, :age, :breed, :image , :price)
    end
  end