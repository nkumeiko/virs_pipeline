class Organization < ApplicationRecord
  self.primary_key = :id

  has_many :vehicles

  validates :name, presence: true
end