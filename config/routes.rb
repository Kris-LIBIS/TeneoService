Rails.application.routes.draw do
  devise_for :users,
             path: '',
             path_names: {
                 sign_in: 'login',
                 sign_out: 'logout',
                 registration: 'signup'
             },
             controllers: {
                 sessions: 'sessions',
                 registrations: 'registrations'
             }
  namespace :api do
    namespace 'v1' do
      # post 'user_token' => 'user_token#create'
      resources :users
      # get 'users/:id/organizations', to: 'users#organizations'
      resources :roles
      resources :memberships
      resources :organizations do
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
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # root to: 'cms/content#show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
