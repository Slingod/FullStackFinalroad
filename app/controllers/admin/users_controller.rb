class Admin::UsersController < ApplicationController
    before_action :authenticate_user!  # Ensures that only a logged in user can access
    before_action :authorize_admin     # Check if it's an admin
    before_action :set_user, only: [ :show, :edit, :update, :destroy ]

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
          format.html { redirect_to admin_users_path, notice: "User successfully deleted." }
          format.turbo_stream
        end
      end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :admin)
    end

    def authorize_admin
      redirect_to root_path, alert: "Access denied." unless current_user.admin?
    end
end
