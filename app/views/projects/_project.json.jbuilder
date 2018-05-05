json.extract! project, :id, :project_name, :tasks, :description, :uid, :user_id, :created_at, :updated_at
json.url project_url(project, format: :json)
