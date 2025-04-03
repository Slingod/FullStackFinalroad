class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :edit, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      if current_user.admin?
        redirect_to admin_users_path, notice: "Utilisateur mis à jour avec succès."
      else
        redirect_to @user, notice: "Votre profil a été mis à jour avec succès."
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end  

  def destroy
    @user.event_users.destroy_all  # Supprime les liens avant de supprimer l'utilisateur

    if @user.destroy
      redirect_to admin_users_path, notice: 'Utilisateur supprimé.'
    else
      redirect_to admin_users_path, alert: 'Erreur lors de la suppression de l’utilisateur.'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to users_path, alert: "Utilisateur non trouvé."
  end

  def authorize_user!
    if current_user != @user && !current_user.admin?
      redirect_to root_path, alert: 'Accès interdit.'
    end
  end

  def user_params
    params.require(:user).permit(:email, :role, :username, :firstname, :show_firstname, :name, :show_name, :show_email, :age, :show_age)
  end
end