Rails.application.routes.draw do
  devise_for :volunteers, controllers: { sessions: "volunteers/sessions", registrations: 'volunteers/registrations' }
  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations" }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :gathering_categories
  resources :gatherings
  get :filter_gatherings, to: 'gatherings#filter_gatherings'

  root to: 'api#index'
end
