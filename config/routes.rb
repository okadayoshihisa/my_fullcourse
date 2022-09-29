Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  root 'static_pages#top'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  post "oauth/callback", to: "oauths#callback"
  get "oauth/callback", to: "oauths#callback"
  get "oauth/:provider", to: "oauths#oauth", as: :auth_at_provider

  get 'privacy', to: 'static_pages#privacy'
  get 'terms', to: 'static_pages#terms'

  resources :users, only: %i[new create edit]
  resources :fullcourse_menus do
    get 'map', on: :collection
    delete 'image_destroy', on: :member
  end
  resources :fullcourses, only: %i[index show]
  resources :stars, only: %i[create destroy]
  resource :profile, only: %i[show edit update] do
    delete 'image_destroy', on: :member
  end
  resources :password_resets, only: %i[new create edit update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
