class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :debug_layout # Log the layout being used
  before_action :authenticate_user!

  # Force Rails to use the correct layout
  layout "application"

  protected

  # Allow Devise to accept additional parameters (username)
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end

  # Allow both Admins and Super Admins to access Admin panel
  def authorize_admin_or_superadmin
    unless current_user&.admin? || current_user&.super_admin?
      redirect_to root_path, alert: "Vous n'êtes pas autorisé à accéder à cette page."
    end
  end

  private

  # Debugging: Log the layout being used
  def debug_layout
    layout_name = self.class._layout 
    Rails.logger.debug "=== CURRENT LAYOUT: #{layout_name.inspect} ==="
  end
end