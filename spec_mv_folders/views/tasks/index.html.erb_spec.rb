require 'rails_helper'

RSpec.describe "tasks/index", type: :view do
  before(:each) do
    assign(:tasks, [
      Task.create!(
        :theme => "",
        :description => "",
        :date_range => "",
        :task_type => "Task Type",
        :task_priority => 2,
        :coments => "",
        :user_id => 3,
        :creator => 4,
        :project_id => 5,
        :logs => "Logs"
      ),
      Task.create!(
        :theme => "",
        :description => "",
        :date_range => "",
        :task_type => "Task Type",
        :task_priority => 2,
        :coments => "",
        :user_id => 3,
        :creator => 4,
        :project_id => 5,
        :logs => "Logs"
      )
    ])
  end

  it "renders a list of tasks" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Task Type".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => "Logs".to_s, :count => 2
  end
end
