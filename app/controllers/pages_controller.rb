class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :dashboard]

  def home
  end

  def dashboard
    @user = current_user
    @favourite_recipes = current_user.favourite_recipes
  end
end
