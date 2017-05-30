class UserMailer < ActionMailer::Base
  default from: 'geeble.gambling@gmail.com'

  def registration_confirmation(user)
    @user = user
    mail(to: "#{user.username} <#{user.email}>", subject: 'Registration Confirmation')
  end

  def gee_winner(user, gee, earnings)
    @user = user
    @gee = gee
    @earnings = earnings
    mail(to: "#{user.username} <#{user.email}>", subject: 'Gee results')
  end

  def gee_looser(user, gee)
    @user = user
    @gee = gee
    mail(to: "#{user.username} <#{user.email}>", subject: 'Gee results')
  end

end
