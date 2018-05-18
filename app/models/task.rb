class Task
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  include AvatarHelper
  validates :theme, :task_type, :task_priority, presence: true

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
  field :project_id, type: String
  # field :log, type: String
  field :logs, type: Array, default: []
  field :teken_time, type: String
  field :pic, type: BSON::Binary
  attr_accessor :coment, :log, :user, :time, :time_start
  # belongs_to :user
  after_initialize :gen_pic, if: :new_record?
  before_save :write_finish
  def gen_pic
    create_task_icon(self.id)
    file = "tmp/#{self.id}.png"
    self.pic = BSON::Binary.new(File.read(file))
    FileUtils.rm(file)
  end

  def write_finish
    if self.log == "Fixed"
      self.teken_time = Time.now
      self.date_range = (Date.parse(self.estimate_time)..Date.parse(self.teken_time))
    end
  end
  # before_save do
  #   self.logs << self.log
  #   self.coments << self.coment
  # end
  has_many :project, autosave: true
  accepts_nested_attributes_for :project, allow_destroy: true

end
