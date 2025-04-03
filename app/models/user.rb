class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  before_save :prevent_admin_change

  # Associe l'utilisateur aux événements via la table de jointure 'event_users'
  has_many :event_users, dependent: :destroy
  has_many :events, through: :event_users

  validates :age, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true

  after_initialize :set_default_visibility

  # Méthodes pour vérifier les rôles
  def admin?
    role == "admin" || role == "administrateur"
  end

  def super_admin?
    role == "super_admin"
  end

  def user?
    role == "user"
  end

  def can_manage?(other_user)
    return false if other_user.super_admin? && !self.super_admin?
    return false if other_user.admin? && !self.super_admin?
    true
  end

  def over_18?
    age.present? && age >= 18
  end

  def participating?(event)
    events.include?(event)
  end

  def join_event(event)
    events << event unless participating?(event)
  end

  def leave_event(event)
    events.delete(event)
  end

  private

  def set_default_visibility
    self.show_name ||= false
    self.show_firstname ||= false
    self.show_email ||= false
    self.show_age ||= false
  end

  def prevent_admin_change
    return unless self.role_changed?

    current_user = self.class.find_by(id: self[:current_user_id]) if self[:current_user_id]
    if current_user && !current_user.super_admin? && self.super_admin?
      errors.add(:role, "ne peut pas être modifié par un non-superadministrateur")
      throw(:abort)
    end
  end
end