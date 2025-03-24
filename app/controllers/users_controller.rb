class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def show
    render template: "users/show", locals: { user: @user }
  end

  def edit
    # Load user info for editing
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "User was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    # Delete dependencies before deleting the user
    @user.event_users.destroy_all   # Delete all event associations of the user

    if @user.destroy
      redirect_to root_path, notice: "Your account has been successfully deleted."
    else
      redirect_to user_path(@user), alert: "Failed to delete the account. Please try again."
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation,
                                 :name, :firstname, :age, :show_name, :show_firstname,
                                 :show_email, :show_age)
  end

  def authorize_user!
    return if current_user == @user

    unless current_user.super_admin? || (current_user.admin? && @user.user?)
      redirect_to root_path, alert: "You are not authorized to perform this action."
    end
  end
end