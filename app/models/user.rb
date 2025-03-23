class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  before_save :prevent_admin_change

  # Association for event participation
  has_many :event_users
  has_many :events, through: :event_users

  # Ensure age is a positive number or nil
  validates :age, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true

  # Default values for visibility settings
  after_initialize :set_default_visibility

  def admin?
    self.admin
  end

  def super_admin?
    self.super_admin
  end

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
    return unless self.admin_changed?

    current_user = self.class.find_by(id: self[:current_user_id]) if self[:current_user_id]
    if current_user && !current_user.admin?
      errors.add(:admin, "cannot be changed like this")
      throw(:abort)
    end
  end
end
