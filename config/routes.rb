SchoolClosing::Application.routes.draw do

  resources :schools, :only => [:show]

  get "about/index"
  match '/templates/compare.html', :to => redirect('/templates/compare.html')

  root :to => "home#index"
end
