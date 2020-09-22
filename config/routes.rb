Rails.application.routes.draw do
  devise_for :users
  root to: "jobs#index"

  resources :jobs, only:[:index, :new, :create]
end
