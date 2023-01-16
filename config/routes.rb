Rails.application.routes.draw do
  devise_for :volunteers
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :gathering_categories
  resources :gatherings
  get :filter_gatherings, to: 'gatherings#filter_gatherings'
end
