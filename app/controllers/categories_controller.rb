class CategoriesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[splash]

  def index 
    @categories = current_user.ordered_groups 
  end

  def new
  end

  def splash; end
end
