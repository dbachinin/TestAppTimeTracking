class Project
  include Mongoid::Document
  attr_accessor :user
  field :project_name, type: String
  # field :tasks, type: Array, default: []
  field :description, type: String
  field :uid, type: String
  field :user_ids, type: Array, default: []
  field :back_uid, type: String
  field :user_id, type: String
  has_many :project, autosave: true
  accepts_nested_attributes_for :project, allow_destroy: true
  after_initialize :gen_uid, if: :new_record?
  before_save :save_uid, unless: :new_record?
  before_destroy :del_tasks
  def gen_uid
    self.uid = SecureRandom.uuid[6..12]
    self.back_uid = self.uid
  end

  def save_uid
    self.uid = back_uid
  end
  def del_tasks
    id = self.id
    Task.where(project_id: id).delete
  end

end
