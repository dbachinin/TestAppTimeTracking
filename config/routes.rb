Rails.application.routes.draw do
  get 'people/index'

  get 'people/show'

  get 'people/edit'

  get 'people/update'

  get 'people/destroy'

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
