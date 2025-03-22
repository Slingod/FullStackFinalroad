class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  before_save :prevent_admin_change

  # Association for event participation
  has_many :event_users
  has_many :events, through: :event_users

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

  def prevent_admin_change
    return unless self.admin_changed?

    current_user = self.class.find_by(id: self[:current_user_id]) if self[:current_user_id]
    if current_user && !current_user.admin?
      errors.add(:admin, "cannot be changed like this")
      throw(:abort)
    end
  end
end
