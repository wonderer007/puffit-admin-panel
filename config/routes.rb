Rails.application.routes.draw do

  devise_for :users

  root "home#index"
  resources :campaigns do 
    resources :delivery_report, :only => [:index]
  end

  resources :responses

  get 'followers' => 'home#followers', :as => :followers
  get 'follower/profile/:id' => 'home#profile', :as => :profile

end