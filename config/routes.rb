Rails.application.routes.draw do
  get 'welcome/index'

  root 'welcome#index'

  devise_for :users
  resources :phones
  resources :accounts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
