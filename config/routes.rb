Rails.application.routes.draw do
  get 'sessions/new'
  devise_for :users
  root to: "items#index"

  get 'items/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  resources :items,only: [:index, :new, :create, :show,:edit,:update]#,:destroy]

end
