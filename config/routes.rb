Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :projects, only: [:show] do
    resources :todos
  end

  resources :todos, only: [:show, :edit] do
    resources :comment
    post 'complete', to: 'todos#complete'
  end
end
