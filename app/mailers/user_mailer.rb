class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.notify_comment.subject
  #
  def notify_comment
    # @greeting = "Hi"
    #
    # mail to: "withvictor@gmail.com"
    @greeting  = 'dasdasasdasd'
    mail(:to =>'withvictor@gmail.com', :subject => "New Comment")
  end

   
end
