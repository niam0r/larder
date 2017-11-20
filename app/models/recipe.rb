class Recipe < ApplicationRecord
  has_many :ingredients
  belongs_to :user
end
