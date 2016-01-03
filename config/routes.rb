Rails.application.routes.draw do

  namespace :admin do
    DashboardManifest::DASHBOARDS.each do |dashboard_resource|
      resources dashboard_resource
    end

    root controller: DashboardManifest::ROOT_DASHBOARD, action: :index
  end

  mount RailsAdmin::Engine => '/admin2', as: 'rails_admin'

  root to: 'visitors#index'

  devise_for :users

  get '/shops', to: 'shops#index'
  post '/shops/find', to: 'shops#find'

  # resources :users
end
