class PicturesController < ApplicationController
    before_action :set_picture, only: [:show, :edit, :update, :destroy]
  
    # Liste de toutes les pictures
    def index
      @pictures = Picture.all
    end
  
    # Affichage d'une picture spécifique
    def show
    end
  
    # Formulaire pour créer une nouvelle picture
    def new
      @picture = Picture.new
    end
  
    # Création d'une nouvelle picture
    def create
      @picture = Picture.new(picture_params)
      if @picture.save
        redirect_to @picture, notice: 'Picture was successfully created.'
      else
        render :new
      end
    end
  
    # Mise à jour d'une picture existante
    def update
      if @picture.update(picture_params)
        redirect_to @picture, notice: 'Picture was successfully updated.'
      else
        render :edit
      end
    end
  
    # Suppression d'une picture
    def destroy
      @picture.destroy
      redirect_to pictures_url, notice: 'Picture was successfully destroyed.'
    end
  
    private
  
    # Méthode pour trouver une picture par son ID
    def set_picture
      @picture = Picture.find(params[:id])
    end
  
    # Méthode pour définir les paramètres autorisés pour les actions CRUD
    def picture_params
      params.require(:picture).permit(:name, :age, :breed, :image , :price)
    end
  end