class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  before_save :prevent_admin_change

  def admin?
    self.admin
  end

  private

  def prevent_admin_change
    if self.admin_changed? && !User.current_admin
      errors.add(:admin, "cannot be changed like this")
      throw(:abort)
    end
  end
end