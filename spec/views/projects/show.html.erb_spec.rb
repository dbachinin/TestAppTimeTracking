require 'rails_helper'

RSpec.describe "projects/show", type: :view do
  before(:each) do
    @project = assign(:project, Project.create!(
      :project_name => "Project Name",
      :tasks => "",
      :description => "Description",
      :uid => "Uid",
      :user_id => "User"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Project Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/Uid/)
    expect(rendered).to match(/User/)
  end
end
