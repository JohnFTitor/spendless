class CategoriesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[splash]

  def index; end

  def splash; end
end
