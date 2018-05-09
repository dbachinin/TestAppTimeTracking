class TasksMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.tasks_mailer.submitted.subject
  #
  def submitted
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
