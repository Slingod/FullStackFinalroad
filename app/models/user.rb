class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  before_save :prevent_admin_change

  def admin?
    self.admin
  end

  def super_admin?
    self.super_admin
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
