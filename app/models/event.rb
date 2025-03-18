class Event < ApplicationRecord
  has_one_attached :picture  

  
  validates :title, presence: true
  validates :author, presence: true
  validates :location, presence: true
  validates :duration, presence: true
  validates :price, presence: true
  validates :date, presence: true
end
