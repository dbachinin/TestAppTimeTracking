class User
  include Mongoid::Document
  include AvatarHelper
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, 
  :recoverable, :rememberable, :trackable, :validatable, :confirmable, authentication_keys: [:name] || [:email]
  after_initialize :create_name, if: :new_record?
  # after_initialize :get_logname, unless: :new_record?
  before_save :gen_pic
  before_save :add_admin
  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""
  field :name,               type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String
  
  field :avatar,             type: String
  field :admin,              type: Mongoid::Boolean
  field :pic,                type: BSON::Binary
  validates :name, presence: true, uniqueness: {case_sensitive: false}

  validates_format_of :name, with: /^[a-zA-Z0-9_\.]*$/, multiline: true
  def add_admin
    unless User.first
      self.admin = 1
    end
  end
  
def self.find_for_database_authentication(conditions={})
  if conditions[:name].include?("@")
   find_by(email: conditions[:name])
  else
   find_by(name: conditions[:name])
 end
end

  private
  def create_name
    if self.name.blank?
      email = self.email.split(/@/)
      name_taken = User.where(name: email[0]).first
      unless name_taken
        self.name = email[0] 
      else    
        self.name = self.email unless email[1]
        self.name = email[0] + SecureRandom.random_number(1_000_000).to_s if email[1] 
      end
    end
  end
  def gen_pic
    create_avatar(self.id)
    file = "tmp/#{self.id}.png"
    self.pic = BSON::Binary.new(File.read(file))
    FileUtils.rm(file)
  end
  
  has_many :project, autosave: true
  has_many :task, autosave: true
  accepts_nested_attributes_for :project, :task, allow_destroy: true
  # accepts_nested_attributes_for :project
  # attr_accessor :name, :email, :password, :password_confirmation, :remember_me

  ## Confirmable
  field :confirmation_token,   type: String
  field :confirmed_at,         type: Time
  field :confirmation_sent_at, type: Time
  field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time
end
