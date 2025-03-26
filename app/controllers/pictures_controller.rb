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
        redirect_to @picture, notice: 'L'image a été créée avec succès.'
      else
        render :new
      end
    end
  
    # Updating an existing picture
    def update
      if @picture.update(picture_params)
        redirect_to @picture, notice: 'L'image a été mise à jour avec succès.'
      else
        render :edit
      end
    end
  
    # Deleting a picture
    def destroy
      @picture.destroy
      redirect_to pictures_url, notice: 'L'image a été détruite avec succès.'
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