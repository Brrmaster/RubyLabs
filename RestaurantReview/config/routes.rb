Rails.application.routes.draw do
  devise_for :users
  resources :restaurants do
  	resources :reviews
  end
  root 'restaurants#index'
end
