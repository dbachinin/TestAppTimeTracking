class TasksMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.tasks_mailer.submitted.subject
  #
  def submitted(user,task,old_task)
    @user = user
    @task = task
    @old_task = old_task
	@task_type = [["Error", 0],["Cosmetic", 1],["Exception", 2], ["Teature", 3],["Task", 4], ["Usability", 5], ["Performance", 6]]
	@task_priority = [["Emergency", 0], ["Critical", 1], ["Serious", 2], ["Regular", 3], ["Low", 4]]
  mails_to = User.find(@task.user_id).map{|i|i.email}
  mails_to << User.find(@task.creator).email
    
    	mail(to: mails_to.uniq, subject: "#{@task.creator} #{task.theme} in #{Project.find(@task.project_id).project_name}")
    
  end
  # def messages()
  # 	User.find(@task.user_id).each do |i|
  # 		mail(to: i.email, subject: "TimeTracking for #{task.theme}")
  # 	end
  # end
end
