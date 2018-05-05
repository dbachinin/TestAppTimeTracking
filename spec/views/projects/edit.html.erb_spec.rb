require 'rails_helper'

RSpec.describe "projects/edit", type: :view do
  before(:each) do
    @project = assign(:project, Project.create!(
      :project_name => "MyString",
      :tasks => "",
      :description => "MyString",
      :uid => "MyString",
      :user_id => "MyString"
    ))
  end

  it "renders the edit project form" do
    render

    assert_select "form[action=?][method=?]", project_path(@project), "post" do

      assert_select "input[name=?]", "project[project_name]"

      assert_select "input[name=?]", "project[tasks]"

      assert_select "input[name=?]", "project[description]"

      assert_select "input[name=?]", "project[uid]"

      assert_select "input[name=?]", "project[user_id]"
    end
  end
end
