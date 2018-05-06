class Task
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  field :theme, type: String
  field :description, type: String, default: ""
  field :date_range, type: Range
  field :task_type, type: Integer
  field :task_priority, type: Integer
  field :estimate_time, type: String
  # field :coment, type: String
  field :coments, type: Array, default: []
  field :user_id, type: Array, default: []
  field :creator, type: String
  field :project_id, type: Integer
  # field :log, type: String
  field :logs, type: Array, default: []
  field :teken_time, type: String
  attr_accessor :coment, :log
  
  after_initialize do
    self.user_id.compact!
  end
  # before_save do
  #   self.logs << self.log
  #   self.coments << self.coment
  # end

end
