class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def welcome_email
    @user = params[:user]
    @url  = 'http://www.cocobank.net'
    mail(to: @user.email, subject: 'CoCoBank_カウンセラー登録が完了しました')
  end

  def reject_email
    @user = params[:user]
    @url  = 'http://www.cocobank.net'
    mail(to: @user.email, subject: 'CoCoBank_カウンセラー登録結果通知')
  end

end
