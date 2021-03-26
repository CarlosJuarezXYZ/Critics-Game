Rails.application.routes.draw do
  resources :games do
    resources :critics
    resources :platforms, only: %i[create new]
    resources :genres, only: %i[create new]
    resources :gamecompanies, only: %i[create new]
  end
  resources :companies
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  root 'games#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
