class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin_or_superadmin
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    # Display a single user's profile
  end

  def edit
    # Prevent non-SuperAdmins from editing SuperAdmins
    if @user.super_admin? && !current_user.super_admin?
      redirect_to admin_users_path, alert: "Vous ne pouvez pas modifier un SuperAdmin!"
    end
  end

  def update
    # Prevent non-SuperAdmins from modifying SuperAdmins
    if @user.super_admin? && !current_user.super_admin?
      return redirect_to admin_users_path, alert: "Vous ne pouvez pas modifier un SuperAdmin!"
    end

    safe_params = params.require(:user).permit(:email, :username, :name, :firstname, :age, :role)

    # Prevent non-SuperAdmins from promoting users to SuperAdmin
    if safe_params[:role] == "super_admin" && !current_user.super_admin?
      return redirect_to admin_users_path, alert: "Vous n'êtes pas autorisé à promouvoir des utilisateurs au rang de SuperAdmin!"
    end

    if @user.update(safe_params)
      redirect_to admin_users_path, notice: "L'utilisateur a été mis à jour avec succès."
    else
      flash[:alert] = "Échec de la mise à jour de l'utilisateur. Veuillez réessayer.."
      render :edit
    end
  end

  def destroy
    # Prevent non-SuperAdmins from deleting SuperAdmins
    if @user.super_admin? && !current_user.super_admin?
      return redirect_to admin_users_path, alert: "Vous ne pouvez pas supprimer un SuperAdmin!"
    end

    # Delete dependencies before deleting the user
    @user.event_users.destroy_all   # Delete all event associations of the user

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
    # Ensure only admins or super-admins can access these actions
    redirect_to root_path, alert: "Accès refusé" unless current_user.admin? || current_user.super_admin?
  end
end
