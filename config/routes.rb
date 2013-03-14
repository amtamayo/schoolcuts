SchoolClosing::Application.routes.draw do

  resources :schools, :only => [:show]

  get "about/index"

  root :to => "home#index"
end
