class Merchant < ApplicationRecord
  has_many :items
  
  validates_presence_of :name, :created_at, :updated_at
end
