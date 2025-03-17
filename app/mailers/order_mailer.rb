class OrderMailer < ApplicationMailer
    def new_order_email
      @order = params[:order]
  
      mail(to: ENV['ADMIN_EMAIL'], subject: "Nouvelle commande reçue !")
    end
  end  