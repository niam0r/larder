class AddPhotoToRecipes < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :photo, :string
  end
end
