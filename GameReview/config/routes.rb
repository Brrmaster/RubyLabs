Rails.application.routes.draw do
  devise_for :users
  devise_for :views
	resources :games  do
		resources :reviews
	end
	root 'games#index'
end
