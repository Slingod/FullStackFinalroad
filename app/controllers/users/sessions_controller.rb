class Users::SessionsController < Devise::SessionsController
    def destroy
      puts "Séance de destruction..."
      super
    end
  end
  