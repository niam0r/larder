class Recipe < ApplicationRecord
  has_many :quantities
  has_many :ingredients, through: :quantities
  belongs_to :user

  mount_uploader :photo, PhotoUploader

  accepts_nested_attributes_for :quantities
end
