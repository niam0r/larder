class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :dashboard]

  def home
  end

  def dashboard
    @user = current_user
    @favourites = Favourite.where(user_id: current_user.id)
    @recipes = @favourites.map { |fav| fav.recipe }
  end
end
