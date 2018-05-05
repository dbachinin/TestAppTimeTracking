FactoryBot.define do
  
  factory :project do
    project_name "Test1"
    user_id 1
    tasks "1,2,3"
    description "test description"
    uid { SecureRandom.uuid }
  end

end