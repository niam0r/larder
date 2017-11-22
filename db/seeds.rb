require 'faker'

puts 'Cleaning database...'
Quantity.destroy_all
Favourite.destroy_all
Ingredient.destroy_all
Recipe.destroy_all
User.destroy_all


puts 'Creating user'

5.times do
user = User.create!(
    email: Faker::Internet.email,
    encrypted_password: "password",
    password: "password",
    avatar: "http://via.placeholder.com/100x100"
    )
end

p 'Finished'

puts 'Creating ingredients...'

20.times do
  ingredient = Ingredient.create!(
  name: Faker::Food.ingredient
  )
end
p 'finished ingredients'

puts 'Creating recipes...'
10.times do
  user_choice = User.all.sample
  recipe = Recipe.create!(
    user_id: user_choice[:id],
    name: Faker::Food.dish,
    description: Faker::Company.catch_phrase,
    duration: Faker::Number.between(10, 60),
    cuisine: Faker::Demographic.demonym,
    servings: Faker::Number.between(1, 6),
    photo: "http://via.placeholder.com/300x400"
    )
end

puts 'Finished!'

puts 'creating quantities'
5.times do
  ingredient_choice = Ingredient.all.sample
  recipe_choice = Recipe.all.sample
  quantity = Quantity.create!(
    ingredient_id: ingredient_choice[:id],
    recipe_id: recipe_choice[:id],
    quantity: Faker::Number.between(10, 30),
    )
end

puts 'finished quantities'

Recipe.first.quantities.create!(
ingredient: Ingredient.first,
quantity: Faker::Number.between(10, 30),
  )
Recipe.last.quantities.create!(
ingredient: Ingredient.first,
quantity: Faker::Number.between(10, 30),
  )

Recipe.first.quantities.create!(
ingredient: Ingredient.last,
quantity: Faker::Number.between(10, 30),
  )
Recipe.last.quantities.create!(
ingredient: Ingredient.last,
quantity: Faker::Number.between(10, 30),
  )





