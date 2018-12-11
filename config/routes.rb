Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  namespace :api do
    namespace 'v1' do
      # post 'user_token' => 'user_token#create'
      resources :users, shallow: true do
        resources :memberships, shallow: true do
          resources :roles
          resources :organizations, shallow: true do
            resources :ingest_agreements, shallow: true do
              resources :ingest_models
              resources :ingests, shallow: true do
                resources :items, shallow: true do
                  resources :status_logs
                end
              end
            end
          end

        end
      end
      # get 'users/:id/organizations', to: 'users#organizations'
      resources :code_tables
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
