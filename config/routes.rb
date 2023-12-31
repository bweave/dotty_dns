Rails.application.routes.draw do
  devise_for :users, skip: [:registrations], sign_out_via: [:get]
  as :user do
    get "users/edit" => "devise/registrations#edit",
        :as => "edit_user_registration"
    put "users" => "devise/registrations#update", :as => "user_registration"
  end

  authenticate :user, ->(user) { user.admin? } do
    mount GoodJob::Engine => "/jobs"
  end

  resources :blocklists do
    get "refresh_all", on: :collection
    get "refresh", on: :member
  end
  resources :dns_records
  resources :dns_queries, only: %i[index]
  get "/dashboard" => "dns_queries#index", :as => :dashboard

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", :as => :rails_health_check

  # Defines the root path route ("/")
  root "dns_queries#index"
end
