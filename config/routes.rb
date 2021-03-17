Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: 'users/registrations'}

  devise_scope :user do
    get "/", to: 'devise/sessions#new'
  end
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

  post 'deals/:id/in_process', to: 'deals#in_process', as: 'in_process'
  post 'deals/:id/rejected', to: 'deals#rejected', as: 'rejected'
  post 'deals/:id/closed', to: 'deals#closed', as: 'closed'
end


