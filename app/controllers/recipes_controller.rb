class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]


  def index
    @recipes = Recipe.all
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


