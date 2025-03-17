class OrdersController < ApplicationController
    def create
      @order = Order.new(order_params)
  
      if @order.save
        OrderMailer.with(order: @order).new_order_email.deliver_later
  
        flash[:success] = "Thank you for your order! We will contact you soon."
        redirect_to root_path
      else
        flash.now[:error] = "Error in the form. Please check and try again."
        render :new
      end
    end
  
    private
  
    def order_params
      params.require(:order).permit(:name, :email, :message)
    end
  end  