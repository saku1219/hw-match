Rails.application.routes.draw do
  devise_for :users
  root to: "works#index"

  resources :works do
    resources :comments, only: [:create, :destroy]
    resources :chats, only: [:show, :create, :destroy] do
      resources :messages, only: :create
    end
    patch "/chats/:id", to: "chats#check"
  end
  resources :users, only: :show
end
