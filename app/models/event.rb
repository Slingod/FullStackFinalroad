class Event < ApplicationRecord
  has_many_attached :media_files

  validates :title, :description, :price, :location, presence: true
end
