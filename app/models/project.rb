class Project
  include Mongoid::Document
  field :project_name, type: String
  field :tasks, type: Array, default: []
  field :description, type: String
  field :uid, type: String
  field :user_id, type: String
  attr_accessor :task
  belongs_to :user
  belongs_to :task
  after_create do
  	self.tasks.compact!
  end
  has_many :project, autosave: true
  accepts_nested_attributes_for :project, allow_destroy: true
end
