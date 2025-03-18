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
  end

    def update
      @user = User.find(params[:id])
      safe_params = params.require(:user).permit(:email)
      safe_params[:admin] = params[:user][:admin] if current_user.admin?
    
      if @user.update(safe_params)
        redirect_to admin_users_path, notice: "User updated"
      else
        render :edit
      end
    end    

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_path, notice: "User deleted successfully." }
      format.turbo_stream
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params(current_user)
    params.require(:user).permit(:email, :admin).tap do |safe_params|
      safe_params[:current_user] = current_user if current_user.admin?
    end
  end

  def authorize_admin_or_superadmin
    redirect_to root_path, alert: "Access Denied" unless current_user.admin? || current_user.super_admin?
  end
end
