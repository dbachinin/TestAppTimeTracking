class Project
  include Mongoid::Document
  field :project_name, String 
  field :user_id, type: Integer
  field :tasks, type: String
  field :description, type: String
  field :uid, type: String
end
