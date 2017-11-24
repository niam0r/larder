require 'open-uri'

puts 'Cleaning database...'
Quantity.destroy_all
Favourite.destroy_all
Ingredient.destroy_all
Recipe.destroy_all
User.destroy_all

# puts 'Creating user'

# 5.times do
#   user = User.create!(
#       email: Faker::Internet.email,
#       encrypted_password: "password",
#       password: "password",
#       avatar: "http://via.placeholder.com/100x100"
#       )
#   end

#   puts 'Finished'

user = User.create!(
  email: 'admin@admin.com',
  password: "password",
  avatar: "http://via.placeholder.com/100x100"
)

base_url = "https://www.bbcgoodfood.com/"
base_url_category = "https://www.bbcgoodfood.com/recipes/collection/"
suffix_url_category = "?page="

categories = [
  "five-ingredients-or-less",
  "christmas-biscuits"
]

# splits a "250g cherry tomatoes" into cherry tomatoes ingreident and 250g dose
ingredient_regex = /(([\d|½]+ x )?[\d|½]+g?( tbsp)?( cans?)?( tub)?( bag)?( pack)?\w*) ([\w| ]*)/
backup_ingredient_regex = /\A(\w+) ([\w| ]+)\z/




categories.each do |category|
  continue = true
  i = 0

  while continue
    puts "NEW PAGE WITH I = #{i}"
    file = open(base_url_category + category + suffix_url_category + i.to_s).read
    main = Nokogiri.HTML(file)
    if main.search('.teaser-item__title a').length == 0
      continue = false
    else
      main.search('.teaser-item__title a').each do |recipe_card|
        file = open(base_url + recipe_card.attribute('href')).read
        doc = Nokogiri.HTML(file)
        new_recipe = Recipe.new
        new_recipe.name = doc.search('.recipe-header__title').text.strip
        new_recipe.description = doc.search('.recipe-header__description').text.strip
        new_recipe.duration = doc.search('.mins').map{ |e| e.text.strip.match(/\d+/)[0].to_i }.reduce(:+)
        new_recipe.servings = doc.search('.recipe-details__text').text.strip.match(/\d+/)[0].to_i
        new_recipe.method = doc.search('.method').text.strip
        new_recipe.user = user
        new_recipe.remote_photo_url = 'https:' + doc.search('.img-container img').attribute('src')
        new_recipe.save!

        doc.search('.ingredients-list__item').each do |ingredient|
          ingredient.search('span').remove

          match_data = ingredient.text.strip.match(ingredient_regex)
          if match_data
            dose = match_data[1]
            ingredient_name = match_data[8]
            ingredient = Ingredient.find_by(name: ingredient_name)
            unless ingredient
              ingredient = Ingredient.create!(name: ingredient_name)
            end

            Quantity.create!(ingredient: ingredient, recipe: new_recipe, quantity: dose)
          else
            ingredient = Ingredient.create!(name: ingredient.text.strip)
            Quantity.create!(ingredient: ingredient, recipe: new_recipe)
          end
        end

        puts "done for #{new_recipe.name}!"
      end
    end

    i += 1
  end

  # puts "*** done for #{category}! ***"
end


# puts 'Creating ingredients...'

# 20.times do
#   ingredient = Ingredient.create!(
#   name: Faker::Food.ingredient
#   )
# end
# p 'finished ingredients'

# puts 'Creating recipes...'
# 10.times do
#   user_choice = User.all.sample
#   recipe = Recipe.create!(
#     user_id: user_choice[:id],
#     name: Faker::Food.dish,
#     description: Faker::Company.catch_phrase,
#     duration: Faker::Number.between(10, 60),
#     cuisine: Faker::Demographic.demonym,
#     servings: Faker::Number.between(1, 6),
#     photo: "http://via.placeholder.com/300x400"
#     )
# end

# puts 'Finished!'

# puts 'creating quantities'
# 5.times do
#   ingredient_choice = Ingredient.all.sample
#   recipe_choice = Recipe.all.sample
#   quantity = Quantity.create!(
#     ingredient_id: ingredient_choice[:id],
#     recipe_id: recipe_choice[:id],
#     quantity: Faker::Number.between(10, 30),
#     )
# end

# puts 'finished quantities'

# Recipe.first.quantities.create!(
# ingredient: Ingredient.first,
# quantity: Faker::Number.between(10, 30),
#   )
# Recipe.last.quantities.create!(
# ingredient: Ingredient.first,
# quantity: Faker::Number.between(10, 30),
#   )

# Recipe.first.quantities.create!(
# ingredient: Ingredient.last,
# quantity: Faker::Number.between(10, 30),
#   )
# Recipe.last.quantities.create!(
# ingredient: Ingredient.last,
# quantity: Faker::Number.between(10, 30),
#   )





