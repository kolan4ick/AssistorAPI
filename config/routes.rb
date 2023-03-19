Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  namespace :api do
    namespace :v1 do
      devise_for :volunteers, controllers: { sessions: "volunteers/sessions", registrations: 'volunteers/registrations' }, singular: "volunteer"
      devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations" }, singular: "user"
      resources :gathering_categories
      resources :gatherings do
        post :create_view, to: 'gatherings#create_view'
        get :viewed, to: 'gatherings#viewed', on: :collection
      end
      get :filter_gatherings, to: 'gatherings#filter_gatherings'
    end
  end

  root to: 'api#index'
end
