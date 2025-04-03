class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin_or_superadmin
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def edit
    if @user.super_admin? && !current_user.super_admin?
      redirect_to admin_users_path, alert: "Vous ne pouvez pas modifier un SuperAdmin!"
    end
  end

  def update
    if @user.super_admin? && !current_user.super_admin?
      return redirect_to admin_users_path, alert: "Vous ne pouvez pas modifier un SuperAdmin!"
    end

    safe_params = params.require(:user).permit(:email, :username, :name, :firstname, :age, :role)

    if safe_params[:role] == "super_admin" && !current_user.super_admin?
      return redirect_to admin_users_path, alert: "Vous n'êtes pas autorisé à promouvoir des utilisateurs au rang de SuperAdmin!"
    end

    if @user.update(safe_params)
      redirect_to admin_users_path, notice: "L'utilisateur a été mis à jour avec succès."
    else
      flash[:alert] = "Échec de la mise à jour de l'utilisateur. Veuillez réessayer."
      render :edit
    end
  end

  def destroy
    if @user.super_admin? && !current_user.super_admin?
      return redirect_to admin_users_path, alert: "Vous ne pouvez pas supprimer un SuperAdmin!"
    end

    @user.event_users.destroy_all  # Supprime les liens avant de supprimer l'utilisateur

    if @user.destroy
      redirect_to admin_users_path, notice: "L'utilisateur a été supprimé avec succès."
    else
      redirect_to admin_users_path, alert: "Échec de la suppression de l'utilisateur. Veuillez réessayer."
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def authorize_admin_or_superadmin
    redirect_to root_path, alert: "Accès refusé" unless current_user.admin? || current_user.super_admin?
  end
end