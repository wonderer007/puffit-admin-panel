Rails.application.routes.draw do

  devise_for :users
  root "home#index"
  get 'puffit' => 'home#puffit', :as => :puffit

end