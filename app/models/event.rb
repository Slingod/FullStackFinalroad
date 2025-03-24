class Event < ApplicationRecord
  has_many_attached :pictures
  has_many_attached :videos

  has_many :event_users, dependent: :destroy
  has_many :participants, through: :event_users, source: :user

  validates :title, presence: true
  validates :author, presence: true
  validates :location, presence: true
  validates :duration, presence: true
  validates :price, presence: true
  validates :date, presence: true

  def user_participating?(user)
    event_users.exists?(user_id: user.id)
  end

  def toggle_participation(user)
    if user.confirmed?  
      if user_participating?(user)
        event_users.find_by(user_id: user.id).destroy
      else
        event_users.create(user_id: user.id)
      end
    else
      raise "L'utilisateur doit confirmer son inscription avant de participer."
    end
  end
end
