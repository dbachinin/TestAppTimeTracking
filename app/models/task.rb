class Task
  include Mongoid::Document
  field :theme, type: String
  field :description, type: String
  field :date_range, type: Range
  field :task_type, type: String
  field :task_priority, type: Integer
  field :tame_estimate, type: Time
  field :coments, type: Array
  field :user_id, type: Integer
  field :creator, type: Integer
  field :project_id, type: Integer
  field :logs, type: Array
  field :teken_time, type: Time
end
