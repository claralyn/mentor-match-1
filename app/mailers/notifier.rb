class Notifier < ActionMailer::Base
  default from: "mentormatch@codefellows.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.notification.subject
  #
  def notification(mentor, subject, message)
    @message = message
    @mentor = mentor

    mail to: mentor.personal_email, subject: subject
  end
end
