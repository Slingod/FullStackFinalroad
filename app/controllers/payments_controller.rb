class PaymentsController < ApplicationController
  def new
  end

  def create
    charge = Stripe::Charge.create(
      amount: 5000,
      currency: "eur",
      source: params[:stripeToken],
      description: "Donate"
    )
    flash[:notice] = "Thanks for you're Donation !"
    redirect_to root_path
  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to donate_path
  end
end
