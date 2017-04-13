Rails.application.routes.draw do
  get 'signup' => 'users#new'
  get "signin" => "sessions#new"
  resource :session
  resources :users
  root "welcome#index"
  resources :stories do
    resources :reviews
  end
  get 'stories/filter/:scope' => "stories#index", as: :filtered_stories
  get 'welcome' => "welcome#index"
end
