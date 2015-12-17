Rails.application.routes.draw do

  devise_for :users
  root "home#index"
  get 'followers' => 'home#followers', :as => :followers

end