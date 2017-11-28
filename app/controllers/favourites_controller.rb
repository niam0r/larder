class FavouritesController < ApplicationController
  before_action :set_recipe, only: [ :create ]
  before_action :authenticate_user!

  def create
    # redirect_to root_path if !user_signed_in?
    @favourite = Favourite.new
    @favourite.user = current_user
    @favourite.recipe = @recipe
    # authorize @favourite

    if @favourite.save
      respond_to do |format|
        format.html { redirect_to recipe_path(@recipe) }
        format.js
      end
    else
      respond_to do |format|
        format.html { render 'recipes/show' }
        format.js
      end
    end
  end

  def destroy
    @favourite = Favourite.find(params[:id])
    @recipe = @favourite.recipe
    # authorize @favourite
    @favourite.destroy
    respond_to do |format|
      format.html { recipe_path(@favourite.recipe) }
      format.js { render 'favourites/create.js.erb' }
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end
end


