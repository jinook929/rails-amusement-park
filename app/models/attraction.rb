class Attraction < ApplicationRecord
  has_many :rides
  has_many :users, through: :rides

  validates_presence_of :name, :happiness_rating, :nausea_rating, :tickets, :min_height
end
