class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  def index
    @recipes = Recipe.all
    if params[:recipe].present?
      ingredient_ids = params[:recipe][:ingredient_ids].map(&:to_i)

      @recipes = @recipes.select do |recipe|
        ingredient_ids.all? { |i| recipe.ingredients.pluck(:id).include? i }
      end

      # search_terms = params[:search].split(", ").first(2)
      # search terms is based on the search added in and then split at the comma, then it finds recipes just on the first two ingredients
      # @search = search_terms.join(", ")
      # then create an instance variable of search so that you can then reshow the search terms joined together with ,
      # search_results = []
      # create empty array of search results to store in
      # search_terms.each do |term|
      #   search_results << Recipe.recipe_search(term).pluck(:id)
      # end
      # iterate over each search term and then push each recipe search searched for by id into the array
      # recipe_ids = search_results.reduce(:&)
      # look for search results and join them together (intersection)
      # @recipes = Recipe.where(id: recipe_ids)
      # find/get all recipes by their id
      # if no search term then just show them all
    end

    @favourite_recipes_id = []
    current_user.favourites.each do |favourite|
      @favourite_recipes_id << favourite.recipe_id
    end
  end

  def new
    @recipe = Recipe.new
      @recipe.quantities.build(recipe: @recipe).build_ingredient
  end

  def create
    existing_ingredients = []
    new_ingredients = []
    params['recipe']['quantities_attributes'].values.each do |key, value|
      existing_ingredients << key if key["ingredient_id"].to_i != 0
      new_ingredients << key if key["ingredient_id"].to_i == 0
    end
    a = []
    new_ingredients.each do |ingredient_hash|
      a << [Ingredient.create!(name: ingredient_hash['ingredient_id']), ingredient_hash['quantity']]
    end
    b = []
    existing_ingredients.map! do |ingredient_hash|
      b << [Ingredient.find(ingredient_hash['ingredient_id'].to_i), ingredient_hash['quantity']]
    end
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    binding.pry
    if @recipe.save
      a.concat(b).each do |array|
        Quantity.create!(ingredient: array[0], recipe: @recipe, quantity: array[1])
      end
      redirect_to dashboard_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
   @recipe.update(recipe_params)
   redirect_to recipe_path(@recipe)
  end

  def show
    @favourite = Favourite.new
  end

  def destroy
   @recipe.destroy
   redirect_to dashboard_path
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
   params.require(:recipe).permit(:name, :description, :duration, :cuisine, :servings, :photo, :photo_cache)
  end
end


