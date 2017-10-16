Rails.application.routes.draw do
  resources :topics
  resources :bookmarks

  devise_for :users

  get 'about' => 'welcome#about'
  get 'welcome/index'

  root 'topics#index'
end
