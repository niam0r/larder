class Recipe < ApplicationRecord
  has_many :quantities
  has_many :ingredients, through: :quantities
  belongs_to :user

  include PgSearch
   pg_search_scope :recipe_search,
    associated_against: {
      ingredients: [ :name ]
    }

  mount_uploader :photo, PhotoUploader
end
