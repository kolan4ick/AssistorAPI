Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  namespace :api do
    namespace :v1 do
      devise_for :volunteers, controllers: { sessions: "volunteers/sessions", registrations: 'volunteers/registrations' }
      devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations" }
      resources :gathering_categories
      resources :gatherings
      get :filter_gatherings, to: 'gatherings#filter_gatherings'
    end
  end

  root to: 'api#index'
end
