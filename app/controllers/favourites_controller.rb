class FavouritesController < ApplicationController
  before_action :set_recipe, only: [ :create ]
  before_action :authenticate_user!

  def create
    redirect_to root_path if !user_signed_in?
    @favourite = Favourite.new
    @favourite.user = current_user
    @favourite.recipe = @recipe
    # authorize @favourite
    if @favourite.save
      redirect_to recipe_path(@recipe)
    else
      render 'recipes/show'
    end
  end

  def destroy
    @favourite = Favourite.find(params[:id])
    # authorize @favourite
    @favourite.destroy
    redirect_to recipe_path(@favourite.recipe)
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end
end


