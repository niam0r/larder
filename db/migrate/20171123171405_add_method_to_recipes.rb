class AddMethodToRecipes < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :method, :text
  end
end
