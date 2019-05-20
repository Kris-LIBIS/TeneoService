Rails.application.routes.draw do
  devise_for :users,
             path: 'api',
             path_names: {
                 sign_in: 'login',
                 sign_out: 'logout'
             },
             controllers: {
                 sessions: 'api/sessions'
             }

  mount Api::Root, at:  '/'


=begin
  namespace :api, defaults: {format: 'json'} do
    resources :docs, only: [:index], path: '/swagger'
    scope module: :v1, constraints: Api::VersionConstraints.new(version: 1, default: true) do
      resources :users, only: [:show, :index]
      resources :roles, only: [:index]
      resources :organizations, only: [:show, :index] do
        resources :ingest_agreements, shallow: true do
          resources :ingest_models, shallow: true do
            resources :packages, shallow: true do
              resources :items, shallow: true do
                resources :status_logs, shallow: true
              end
            end
          end
        end
      end
    end
  end
=end
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'admin/dashboard#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
