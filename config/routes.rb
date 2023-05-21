require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  # Defines the root path route ("/")
  root "contracts#index"

  get 'contracts/import', to: 'contracts#import', as: 'import_contracts'
  post 'contracts/process_csv', to: 'contracts#process_csv', as: 'process_csv'

  resources :contracts do
    get :update_frame, on: :collection
  end
end
