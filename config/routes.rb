Rails.application.routes.draw do
  root 'breeds#index'
  post 'breeds/fetch_breed', to: 'breeds#fetch_breed', as: :fetch_breed
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
