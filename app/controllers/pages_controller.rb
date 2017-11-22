class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :dashboard]

  def home
  end

  def dashboard
    @recipe_ids = Favourite.where(user_id: current_user.id)
    @recipes = []
    @recipe_ids.each { |instance| @recipes << Recipe.find(instance.recipe_id) }
  end
end
