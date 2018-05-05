require 'rails_helper'

RSpec.describe "projects/index", type: :view do
  before(:each) do
    assign(:projects, [
      Project.create!(
        :project_name => "Project Name",
        :tasks => "",
        :description => "Description",
        :uid => "Uid",
        :user_id => "User"
      ),
      Project.create!(
        :project_name => "Project Name",
        :tasks => "",
        :description => "Description",
        :uid => "Uid",
        :user_id => "User"
      )
    ])
  end

  it "renders a list of projects" do
    render
    assert_select "tr>td", :text => "Project Name".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Uid".to_s, :count => 2
    assert_select "tr>td", :text => "User".to_s, :count => 2
  end
end
