Rails.application.routes.draw do
  get 'signup' => 'users#new'
  get "signin" => "sessions#new"
  resource :session
  resources :users
  root "stories#index"
  resources :stories do
    resources :reviews
  end
end
