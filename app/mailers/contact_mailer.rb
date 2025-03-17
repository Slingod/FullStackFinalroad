class ContactMailer < ApplicationMailer
  default from: ENV["GMAIL_USERNAME"]

  def contact_email(contact)
    @contact = contact
    mail(to: ENV["GMAIL_USERNAME"], subject: "Nouveau message de contact")
  end
end