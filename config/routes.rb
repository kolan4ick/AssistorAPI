Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  namespace :api do
    namespace :v1 do
      devise_for :volunteers, controllers: { sessions: "volunteers/sessions", registrations: 'volunteers/registrations',
                                             passwords: "volunteers/passwords" }, singular: "volunteer"
      devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations",
                                        passwords: "users/passwords" }, singular: "user"
      resources :gathering_categories
      resources :gatherings do
        post :create_view, to: 'gatherings#create_view'
        get :viewed, to: 'gatherings#viewed', on: :collection
        get 'created_by_volunteer/:volunteer_id', to: 'gatherings#created_by_volunteer', on: :collection
        get :search, to: 'gatherings#search', on: :collection
      end
      resources :favourite_gatherings, only: [:index, :create] do
        delete :destroy, to: 'favourite_gatherings#destroy', on: :collection
      end
      resources :volunteers, only: [:index, :show]
      get :filter_gatherings, to: 'gatherings#filter_gatherings'
    end
  end

  root to: 'api#index'
end
