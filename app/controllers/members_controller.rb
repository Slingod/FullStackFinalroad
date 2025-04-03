class MembersController < ApplicationController
  before_action :authenticate_user! # Only logged-in users can see members
  before_action :set_member, only: [:show] # Load member before specific actions

  def index
    @members = User.all # Fetch all members for display
  end

  def show
    @member = User.find(params[:id]) # Find the member by ID
  end  

  private

  def set_member
    @member = User.find(params[:id]) # Find the member as a User object
  end
end