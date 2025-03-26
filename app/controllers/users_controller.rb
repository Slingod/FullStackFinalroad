class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def show
    render template: "users/show", locals: { user: @user }
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "L'utilisateur a été mis à jour avec succès."
    else
      render :edit
    end
  end

  def destroy
    @user.event_users.destroy_all

    if @user.destroy
      redirect_to root_path, notice: "Votre compte a été supprimé avec succès."
    else
      redirect_to user_path(@user), alert: "Échec de la suppression du compte. Veuillez réessayer."
    end
  end

  private

  def set_user
    Rails.logger.debug "PARAMS[:id]: #{params[:id]}"
    @user = User.find_by(id: params[:id].to_i) || redirect_to(root_path, alert: "Utilisateur introuvable") # 🔹 Sécurisé
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation,
                                 :name, :firstname, :age, :show_name, :show_firstname,
                                 :show_email, :show_age)
  end

  def authorize_user!
    return if current_user == @user

    unless current_user.super_admin? || (current_user.admin? && @user.user?)
      redirect_to root_path, alert: "Vous n'êtes pas autorisé à effectuer cette action."
    end
  end
end