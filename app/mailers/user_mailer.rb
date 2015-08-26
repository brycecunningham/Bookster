class UserMailer < ApplicationMailer
  default :from => 'brycecunningham11@gmail.com'

  def forgot_password(user)
    @user = user
    mail :to => @user.email_addressee, :subject => 'Reset your password'
  end
end
