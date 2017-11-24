class FavouritesController < ApplicationController
  before_action :set_recipe, only: [ :create ]

  def create
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
    redirect_to recipe_path(@favourite.recipe), notice: 'Done!'
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end
end


