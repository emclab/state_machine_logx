Rails.application.routes.draw do

  mount StateMachineLogx::Engine => "/state_machine_logx"
  mount Commonx::Engine => "/commonx"
  mount Authentify::Engine => '/authentify'
  
  #resource :session
  
  root :to => "sessions#new", controller: :authentify
  match '/signin',  :to => 'sessions#new', controller: :authentify
  match '/signout', :to => 'sessions#destroy', controller: :authentify
  match '/user_menus', :to => 'user_menus#index', controller: :main_app
  match '/view_handler', :to => 'application#view_handler', controller: :authentify
end
