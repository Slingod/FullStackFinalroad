class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  before_save :prevent_admin_change

  has_many :event_users
  has_many :events, through: :event_users

  validates :age, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true

  after_initialize :set_default_visibility

  def admin?
    role == "admin"
  end

  def super_admin?
    role == "super_admin"
  end

  def can_manage?(other_user)
    # Admins cannot manage SuperAdmins
    return false if other_user.super_admin? && !self.super_admin?
    # Admins cannot manage other Admins unless they are SuperAdmins
    return false if other_user.admin? && !self.super_admin?
    # Regular users can be managed by Admins and SuperAdmins
    true
  end

  # Check if the user is over 18
  def over_18?
    age.present? && age >= 18
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
      errors.add(:role, "cannot be changed by a non-superadmin")
      throw(:abort)
    end
  end
end
