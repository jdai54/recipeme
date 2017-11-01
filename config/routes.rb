Rails.application.routes.draw do
  get 'likes/index'

  resources :topics do
    resources :bookmarks, except: [:index]
  end

  resources :bookmarks, only: [] do
    resources :likes, only: [:index, :create, :destroy]
  end

  devise_for :users

  get 'about' => 'welcome#about'
  get 'welcome/index'
  post :incoming, to: 'incoming#create'

  root 'topics#index'
end
