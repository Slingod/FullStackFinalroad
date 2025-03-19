class MembersController < ApplicationController
    before_action :authenticate_user! # Only logged-in users can see members
  
    def index
      @members = User.all
    end
  
    def show
      @member = User.find(params[:id])
    end
  end  