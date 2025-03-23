class UsersController < ApplicationController
  before_action :authenticate_user! # Ensure the user is logged in
  before_action :set_user, only: [:show, :edit, :update, :destroy] # Find user before specific actions
  before_action :authorize_user!, only: [:edit, :update, :destroy] # Restrict access for updates/deletion

  def show
    render template: "users/show", locals: { user: @user }
  end

  def edit
    # Load user info for editing
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "User was successfully updated." # Success message
    else
      render :edit # Show edit form with errors
    end
  end

  def destroy
    if @user.destroy
      redirect_to root_path, notice: "Your account has been successfully deleted." # Success message
    else
      redirect_to user_path(@user), alert: "Failed to delete the account. Please try again." # Failure message
    end
  end

  private

  def set_user
    @user = User.find(params[:id]) # Find the user by ID
  end

  def user_params
    # Allow these fields for updates
    params.require(:user).permit(:username, :email, :password, :password_confirmation,
                                 :name, :firstname, :age, :show_name, :show_firstname,
                                 :show_email, :show_age)
  end

  def authorize_user!
    # Ensure the current user is authorized to make changes
    unless current_user == @user || current_user.admin? || current_user.super_admin?
      redirect_to root_path, alert: "You are not authorized to perform this action."
    end
  end
end
