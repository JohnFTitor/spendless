Rails.application.routes.draw do
  devise_for :users

  root "categories#index"

  get '/welcome', to: 'categories#splash', as: 'welcome'

  resources :categories, only: %i[new create index] do 
    resources :transactions, only: %i[new create index] 
  end
  
  resources :users, only: %i[index]
end
