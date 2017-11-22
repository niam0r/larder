class Favourite < ApplicationRecord
  belongs_to :recipe
  belongs_to :user

  validates :user, uniqueness: { scope: :recipe }
end
