class QuantitiesController < ApplicationController
  before_action :set_recipe, only: [ :new, :create ]
  def new
    @quantity = Quantity.new
  end

  def create
     @quantity = Quantity.new(quantity_params)
     @quantity.recipe = @recipe
     if @quantity.save
      redirect_to recipe_path(@recipe)
    else
      render 'new'
    end
  end

  def destroy
    @quantity = Quantity.find(params[:id])
    @recipe = @quantity.recipe
    @quantity.destroy
   redirect_to recipe_path(@recipe)
  end

  private

  def quantity_params
    params.require(:quantity).permit(:quantity, :ingredient_id)
  end

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

end



