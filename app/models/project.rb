class Project
  include Mongoid::Document
  field :project_name, type: String
  field :tasks, type: Array, default: []
  field :description, type: String
  field :uid, type: String
  field :user_id, type: String
  attr_accessor :task
  belongs_to :user
end
