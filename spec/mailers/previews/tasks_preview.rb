# Preview all emails at http://localhost:3000/rails/mailers/tasks
class TasksPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/tasks/submitted
  def submitted
    TasksMailer.submitted
  end

end
