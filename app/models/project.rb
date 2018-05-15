class Project
  include Mongoid::Document
  attr_accessor :task
  field :project_name, type: String
  field :uid_back, type: String
  field :description, type: String
  field :uid, type: String
  field :user_ids, type: Array, default: []
  
  belongs_to :user
  has_many :project, autosave: true
  accepts_nested_attributes_for :project, allow_destroy: true
  after_initialize :gen_uid, if: :new_record?
  
  def gen_uid
    self.uid = SecureRandom.uuid[6..12]
    self.uid_back = self.uid
  end
protected
# def attributes_protected_by_default
#   super.uid
# end
end
