require 'rails_helper'

RSpec.describe "projects/new", type: :view do
  before(:each) do
    assign(:project, Project.new(
      :project_name => "MyString",
      :tasks => "",
      :description => "MyString",
      :uid => "MyString",
      :user_id => "MyString"
    ))
  end

  it "renders new project form" do
    render

    assert_select "form[action=?][method=?]", projects_path, "post" do

      assert_select "input[name=?]", "project[project_name]"

      assert_select "input[name=?]", "project[tasks]"

      assert_select "input[name=?]", "project[description]"

      assert_select "input[name=?]", "project[uid]"

      assert_select "input[name=?]", "project[user_id]"
    end
  end
end
