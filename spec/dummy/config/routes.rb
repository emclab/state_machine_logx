Rails.application.routes.draw do

  mount StateMachineLogx::Engine => "/state_machine_logx"
  mount Commonx::Engine => "/commonx"
  mount Authentify::Engine => '/authentify'
  
  resource :session
  
  root :to => "authentify::sessions#new"
  match '/signin',  :to => 'authentify::sessions#new'
  match '/signout', :to => 'authentify::sessions#destroy'
  match '/user_menus', :to => 'user_menus#index'
  match '/view_handler', :to => 'authentify::application#view_handler'
end
