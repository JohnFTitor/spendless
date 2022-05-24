Rails.application.routes.draw do
  devise_for :users

  root "categories#index"

  resources :categories, only: %i[index]
end
