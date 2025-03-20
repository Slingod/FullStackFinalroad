class Admin::UsersController < ApplicationController
  before_action :authenticate_user! # Ensure the user is logged in
  before_action :authorize_admin_or_superadmin # Restrict access to admins/super-admins
  before_action :set_user, only: [:show, :edit, :update, :destroy] # Find user before specific actions

  def index
    @users = User.all # Fetch all users for display
  end

  def show
    # Display a single user's profile
  end

  def edit
    # Load user info for editing
  end

  def update
    # Permit specific parameters for update
    safe_params = params.require(:user).permit(:email, :username, :name, :firstname, :age, :role)

    # Update boolean fields based on role
    case safe_params[:role]
    when "admin"
      safe_params[:admin] = true
      safe_params[:super_admin] = false
    when "super_admin"
      safe_params[:admin] = true # Super admin should also have admin privileges
      safe_params[:super_admin] = true
    else
      safe_params[:admin] = false
      safe_params[:super_admin] = false
    end

    # Perform the update and handle the response
    if @user.update(safe_params)
      redirect_to admin_users_path, notice: "User updated successfully." # Success message
    else
      flash[:alert] = "Failed to update user. Please try again." # Error message
      render :edit # Show the edit form with errors
    end
  end

  def destroy
    # Attempt to delete the user and respond accordingly
    if @user.destroy
      respond_to do |format|
        format.html { redirect_to admin_users_path, notice: "User deleted successfully." } # Success message
        format.turbo_stream
      end
    else
      redirect_to admin_users_path, alert: "Failed to delete user. Please try again." # Error message
    end
  end

  private

  def set_user
    @user = User.find(params[:id]) # Find the user by ID
  end

  def authorize_admin_or_superadmin
    # Ensure only admins or super-admins can access these actions
    redirect_to root_path, alert: "Access Denied" unless current_user.admin? || current_user.super_admin?
  end
end