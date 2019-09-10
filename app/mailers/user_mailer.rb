class UserMailer < ApplicationMailer
	default from: 'notifications@example.com'

  def welcome_email
    @user = params[:user]
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'CoCoBank_カウンセラー登録が完了しました')
  end
end