class Project
  include Mongoid::Document
  field :project_name, type: String
  field :tasks, type: Array
  field :description, type: String
  field :uid, type: String
  field :user_id, type: String
  belongs_to :user
end
