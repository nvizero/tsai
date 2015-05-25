class UserMailer < ActionMailer::Base


  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.notify_comment.subject
  #
  def notify_comment
    @greeting  = 'dasdasasdasd'
    mail(:to =>'withvictor@gmail.com', :subject => "New Comment")
  end

  def new_user(uu)
    @u = uu
    @msg1 = 'welcome to my web site'
    mail(:to =>@u.email, :subject => @u.name+"您好!註冊成功!")
  end

  def forget_pas(user , str)

    @stri = str
    @u = user
    @msg1 = 'welcome to my web site'
    mail(:to =>@u.email, :subject => @u.name+"您好!您的密碼己變更!")
  end


end
