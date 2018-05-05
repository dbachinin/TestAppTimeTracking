require 'rails_helper'

RSpec.describe Project, type: :model do
# 	it "has a valid factory" do
#   # pending "add some examples to (or delete) #{__FILE__}"
#   # expect(FactoryBot.build(:project).save).to be_true
#   expect(build(:project)).to be_valid
# end
	before(:all) do
		@project = create(:project)
	end
	it "has a valid" do
		expect(FactoryBot.build(:project).save).to be_true
	end
end
