Rails.application.routes.draw do
  devise_for :users
  root to: "works#index"

  resources :works do
    resources :comments, only: [:create, :destroy]
    resources :chats
  end
end
