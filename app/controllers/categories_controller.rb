class CategoriesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[splash]

  def index
    @categories = current_user.ordered_groups
  end

  def new
    group = Group.new
    respond_to do |format|
      format.html { render :new, locals: { group: } }
    end
  end

  def create
    category = Group.new(category_params)
    category.author = current_user
    respond_to do |format|
      format.html do
        if category.save
          flash[:notice] = 'Category created successfully'
          redirect_to '/'
        else
          flash.now[:alert] = 'Error: Please make sure to fill all fields with the proper input'
          render :new, status: 422, locals: { group: category }
        end
      end
    end
  end

  def splash; end

  def category_params
    params.require(:group).permit(:name, :icon)
  end
end
