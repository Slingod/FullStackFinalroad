class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.contact_email(@contact).deliver_now
      flash[:success] = "Your message has been sent successfully. Thank you for contacting us! !"
      redirect_to root_path
    else
      flash[:error] = "An error has occurred. Please check the information entered."
      render :new, status: :unprocessable_entity
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end
