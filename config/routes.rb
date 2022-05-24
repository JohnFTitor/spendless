Rails.application.routes.draw do
  devise_for :users

  root "categories#index"

  get '/welcome', to: 'categories#splash', as: 'splash'

  resources :categories, only: %i[index]
end
