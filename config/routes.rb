Rails.application.routes.draw do
    devise_for :users, :path => 'users'
    resources :users do
    	resources :projects
  	end
  resources :tasks

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "projects#index"
  get "/edit_comments" => 'tasks#edit_coments'
  get "/add_comments" => 'tasks#add_coments'
end
