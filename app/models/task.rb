class Task
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  field :theme, type: String
  field :description, type: String, default: ""
  field :date_range, type: Range
  field :task_type, type: String
  field :task_priority, type: Integer
  field :time_estimate, type: Time
  # field :coment, type: String
  field :coments, type: Array, default: []
  field :user_id, type: String
  field :creator, type: String
  field :project_id, type: Integer
  # field :log, type: String
  field :logs, type: Array, default: []
  field :teken_time, type: Time

  # before_save do
  #   self.logs << self.log
  #   self.coments << self.coment
  # end

end
