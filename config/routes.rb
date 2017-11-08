Rails.application.routes.draw do
  
  devise_for :users
  get 'users/show'

  resources :likes, only: :index
  resources :users
  resources :topics do
    resources :bookmarks, except: [:index]
  end

  resources :bookmarks, only: [] do
    resources :likes, only: [:index, :create, :destroy]
  end

  get 'about' => 'welcome#about'
  get 'welcome/index'
  post :incoming, to: 'incoming#create'

  root 'topics#index'
end
