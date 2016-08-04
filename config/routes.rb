Rails.application.routes.draw do
  root 'welcome#index'

  resources :users, only: [:new, :create]
  resources :user_sessions, only: [:create, :destroy]

  delete '/sign_out', to: 'user_sessions#destroy', as: :sign_out
  get '/sign_in', to: 'user_sessions#new', as: :sign_in

  resources :annoyers
  resources :nodes
  resources :reminders do
    resources :recents
  end

  # graphql
  post '/graphql', to: 'graphql#query'
  if Rails.env.development?
    mount GraphiQL::Rails::Engine,
    at: "/graphiql",
    graphql_path: "/graphql"
  end
  # end graphql
end
