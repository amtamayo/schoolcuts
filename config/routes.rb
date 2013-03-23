SchoolClosing::Application.routes.draw do

  get "compare/show"

  match "/compare/:id" => "compare#show"
  
  resources :schools, :only => [:show]
  resources :compare, :only => [:show]

  get "about/index"
  match '/templates/compare.html', :to => redirect('/templates/compare.html')

  root :to => "home#index"
end
