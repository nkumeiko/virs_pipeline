class Vehicle < ApplicationRecord
  self.primary_key = :id

  belongs_to :organization
end