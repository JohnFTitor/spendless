class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]

  def index
    redirect_to new_user_registration_path
  end
end
