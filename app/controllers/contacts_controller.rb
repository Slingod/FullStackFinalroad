class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      ContactMailer.contact_email(@contact).deliver_now
      flash[:success] = "Votre message a bien été envoyé. Merci de nous avoir contactés!"
      redirect_to root_path
    else
      flash.now[:error] = "Une erreur s'est produite. Veuillez vérifier les informations saisies."
      render :new, status: :unprocessable_entity
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end