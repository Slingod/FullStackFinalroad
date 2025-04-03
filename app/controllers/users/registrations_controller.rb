# app/controllers/users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController
    # Si tu veux personnaliser l'action de création, tu peux définir une méthode create ici
    # Par exemple, si tu veux envoyer un email après l'inscription ou rediriger vers une page spéciale
  
    # Exemple de personnalisation après une inscription réussie
    def after_sign_up_path_for(resource)
      # Redirige l'utilisateur vers la page d'accueil, tu peux aussi mettre d'autres pages comme 'welcome_path'
      root_path
    end
  
    # Tu peux aussi personnaliser l'action d'édition de l'utilisateur
    def edit
      # Si tu veux ajouter des traitements avant de permettre l'édition
      super
    end
  
    # Par défaut, Devise va utiliser 'create' et 'edit'
  end
  