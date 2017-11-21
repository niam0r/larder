class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  def index
    if params[:search]
      search_terms = params[:search].split(", ").first(2)
      # search terms is based on the search added in and then split at the comma, then it finds recipes just on the first two ingredients
      @search = search_terms.join(", ")
      # then create an instance variable of search so that you can then reshow the search terms joined together with ,
      search_results = []
      # create empty array of search results to store in
      search_terms.each do |term|
        search_results << Recipe.recipe_search(term).pluck(:id)
      end
      # iterate over each search term and then push each recipe search searched for by id into the array
      recipe_ids = search_results.reduce(:&)
      # look for search results and join them together (intersection)
      @recipes = Recipe.where(id: recipe_ids)
      # find/get all recipes by their id
    else
      @recipes = Recipe.all
      # if no search term then just show them all
    end
  end

  def new
    @recipe = Recipe.new
    3.times do
      @recipe.quantities.build(recipe: @recipe).build_ingredient
    end
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user

    if @recipe.save
      redirect_to dashboard_path
    else
      render 'new'
    end
  end

  def edit

  end

  def update
   @recipe.update
   redirect_to recipe_path(@recipe)
  end

  def show

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
   params.require(:recipe).permit(:name, :description, :duration, :cuisine, :servings, :photo, quantities_attributes: [:ingredient_id, :quantity])
  end
end


