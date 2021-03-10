Rails.application.routes.draw do
  devise_for :users
  root to: 'products#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :products do
    resources :deals, only: [:create] # I'm assuming you can delete a deal too??
    resources :favorites, only: [:create]
  end
  resources :deals, only: [:show] do
    resources :reviews, only: [:create]
  end
  resources :favorites, only: [:destroy]
  resources :users, only: [:show, :edit, :update]
  resources :chatrooms, only: [:index, :show, :create] do
    resources :messages, only: [:create]
  end

end

# delete this line
