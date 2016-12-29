Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :projects, only: [:show] do
    resources :todos, only: [:new, :create, :update]
  end

  resources :todos, only: [:edit, :show, :destroy] do
    resources :comment
    post 'complete', to: 'todos#complete'
  end
end
