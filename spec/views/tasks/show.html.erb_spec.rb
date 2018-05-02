require 'rails_helper'

RSpec.describe "tasks/show", type: :view do
  before(:each) do
    @task = assign(:task, Task.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Task Type/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(//)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/Logs/)
  end
end
