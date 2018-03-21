Rails.application.routes.draw do
  get 'welcome/index'

  root 'welcome#index'

  devise_for :users
  resources :users
  get 'accounts/import', to: 'accounts#import'
  post 'accounts/import', to: 'accounts#import'

  resources :phones
  resources :accounts

  post 'callbacks/portOutValidationCallbackApi', to:'callbacks#portOutValidationCallbackApi'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
