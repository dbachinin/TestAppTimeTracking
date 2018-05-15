class Project
  include Mongoid::Document
  attr_accessor :task
  field :project_name, type: String
  field :tasks, type: Array, default: []
  field :description, type: String
  field :uid, type: String
  field :user_id, type: String
  
  belongs_to :user
  has_many :project, autosave: true
  accepts_nested_attributes_for :project, allow_destroy: true
  after_initialize :gen_uid, if: :new_record?
  before_save :save_uid, unles: :new_record?
  def gen_uid
    self.uid = SecureRandom.uuid[6..12]
  end

  def save_uid
    self.uid = File.read('tmp/uid')
  end

end
