json.extract! task, :id, :theme, :description, :date_range, :task_type, :task_priority, :tame_estimate, :coments, :user_id, :creator, :project_id, :logs, :teken_time, :created_at, :updated_at
json.url task_url(task, format: :json)
