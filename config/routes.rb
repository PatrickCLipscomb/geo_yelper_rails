Rails.application.routes.draw do
  devise_for :users
  root :to => 'firstmodels#index'
  resources :firstmodels
end
