Rails.application.routes.draw do
  post 'users/change_pic'
    devise_for :users, :path => 'users'
    resources :users, shallow: true do
    	resources :projects, param: :uid do
        resources :tasks
      end
  	end
  # resources :tasks
  # get 'users/:id/projects/:id', to: 'projects#show', as: 'project'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "projects#index"
  get "/edit_comments" => 'tasks#edit_coments'
  get "/add_comments" => 'tasks#add_coments'
end
