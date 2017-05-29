class UserMailer < ActionMailer::Base
  default from: 'geeble.gambling@gmail.com'

  def registration_confirmation(user)
    @user = user
    mail(to: "#{user.username} <#{user.email}>", subject: 'Registration Confirmation')
  end

  def gee_result(gee)
    @gee = gee
    gee.users.each do |user|
      @user = user
      mail(to: "#{user.username} <#{user.email}>", subject: 'Gee results')
    end
  end

end
