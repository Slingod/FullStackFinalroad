class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update]
  before_action :authorize_user!, only: [:edit, :update]

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    if current_user.super_admin?
      params.require(:user).permit(:email, :username, :name, :firstname, :age, :role)
    elsif current_user.admin?
      params.require(:user).permit(:email, :username, :name, :firstname, :age, :role) unless params[:user][:role] == "super_admin"
    else
      params.require(:user).permit(:email, :username, :name, :firstname, :age)
    end
  end

  def authorize_user!
    redirect_to root_path, alert: "Access Denied" unless current_user == @user || current_user.admin? || current_user.super_admin?
  end
end
