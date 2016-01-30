Rails.application.routes.draw do
  root 'welcome#index'
  resources :annoyers
  resources :nodes
  resources :reminders do
    resources :recents
  end
end
