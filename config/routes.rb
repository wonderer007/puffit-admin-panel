Rails.application.routes.draw do

  devise_for :users

  root "home#index"
  resources :campaign
  get 'followers' => 'home#followers', :as => :followers

end