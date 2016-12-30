Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :projects, only: [:show] do
    resources :todos, only: [:new, :create]
  end

  resources :todos, only: [:edit, :show, :destroy, :update] do
    resources :comments, only: [:create]
    post 'complete', to: 'todos#complete'
  end

  resources :teams, only: [:show] do
    get 'events', to: 'events#index'
    get 'events/data', to: 'events#data'
  end
end
