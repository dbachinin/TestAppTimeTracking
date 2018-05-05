class Project
  include Mongoid::Document
  field :project_name, type: String
  field :user_id, type: String
  field :tasks, type: Array, default: []
  field :description, type: String
  field :uid, type: String
  validates :project_name, presence: true 

  # has_and_belongs_to_many :user
end
