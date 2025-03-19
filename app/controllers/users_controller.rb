class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to members_path, notice: 'User was successfully deleted.'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    allowed_params = [:email, :username, :name, :firstname, :age]
    allowed_params << :role if current_user.admin? || current_user.super_admin?
    params.require(:user).permit(allowed_params)
  end

  def authorize_user!
    redirect_to root_path, alert: "Access Denied" unless current_user == @user || current_user.admin? || current_user.super_admin?
  end
end
