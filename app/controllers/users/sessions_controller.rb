class Users::SessionsController < Devise::SessionsController
    def destroy
      puts "Destroying session..."
      super
    end
  end
  