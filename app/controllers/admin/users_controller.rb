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
      redirect_to admin_users_path, alert: "You cannot edit a SuperAdmin!"
    end
  end

  def update
    # Prevent non-SuperAdmins from modifying SuperAdmins
    if @user.super_admin? && !current_user.super_admin?
      return redirect_to admin_users_path, alert: "You cannot modify a SuperAdmin!"
    end

    safe_params = params.require(:user).permit(:email, :username, :name, :firstname, :age, :role)

    # Prevent non-SuperAdmins from promoting users to SuperAdmin
    if safe_params[:role] == "super_admin" && !current_user.super_admin?
      return redirect_to admin_users_path, alert: "You are not allowed to promote users to SuperAdmin!"
    end

    if @user.update(safe_params)
      redirect_to admin_users_path, notice: "User updated successfully."
    else
      flash[:alert] = "Failed to update user. Please try again."
      render :edit
    end
  end

  def destroy
    # Prevent non-SuperAdmins from deleting SuperAdmins
    if @user.super_admin? && !current_user.super_admin?
      return redirect_to admin_users_path, alert: "You cannot delete a SuperAdmin!"
    end

    # Delete dependencies before deleting the user
    @user.event_users.destroy_all   # Delete all event associations of the user

    if @user.destroy
      redirect_to admin_users_path, notice: "User deleted successfully."
    else
      redirect_to admin_users_path, alert: "Failed to delete user. Please try again."
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def authorize_admin_or_superadmin
    # Ensure only admins or super-admins can access these actions
    redirect_to root_path, alert: "Access Denied" unless current_user.admin? || current_user.super_admin?
  end
end
