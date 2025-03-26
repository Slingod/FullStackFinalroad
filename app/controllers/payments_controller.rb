class PaymentsController < ApplicationController
  def new
  end

  def create
    charge = Stripe::Charge.create(
      amount: 5000,
      currency: "eur",
      source: params[:stripeToken],
      description: "Faire un don"
    )
    flash[:notice] = "Merci pour votre don !"
    redirect_to root_path
  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to donate_path
  end
end
