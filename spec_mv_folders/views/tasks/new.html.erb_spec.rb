require 'rails_helper'

RSpec.describe "tasks/new", type: :view do
  before(:each) do
    assign(:task, Task.new(
      :theme => "",
      :description => "",
      :date_range => "",
      :task_type => "MyString",
      :task_priority => 1,
      :coments => "",
      :user_id => 1,
      :creator => 1,
      :project_id => 1,
      :logs => "MyString"
    ))
  end

  it "renders new task form" do
    render

    assert_select "form[action=?][method=?]", tasks_path, "post" do

      assert_select "input[name=?]", "task[theme]"

      assert_select "input[name=?]", "task[description]"

      assert_select "input[name=?]", "task[date_range]"

      assert_select "input[name=?]", "task[task_type]"

      assert_select "input[name=?]", "task[task_priority]"

      assert_select "input[name=?]", "task[coments]"

      assert_select "input[name=?]", "task[user_id]"

      assert_select "input[name=?]", "task[creator]"

      assert_select "input[name=?]", "task[project_id]"

      assert_select "input[name=?]", "task[logs]"
    end
  end
end
