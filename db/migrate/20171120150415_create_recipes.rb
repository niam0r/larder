class CreateRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes do |t|
      t.string :name
      t.text :description
      t.integer :duration
      t.string :cuisine
      t.integer :servings
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
