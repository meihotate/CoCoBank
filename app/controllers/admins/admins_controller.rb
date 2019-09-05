class Admins::AdminsController < ApplicationController

	before_action :user_signed_in
	before_action :authenticate_admin!

	def appro
		@user = User.find(params[:user_id])

	      if @user.update(user_params)
	        # 保存後にUserMailerを使ってwelcomeメールを送信
	        UserMailer.with(user: @user).welcome_email.deliver_later
	        redirect_to root_path
	      else
	        redirect_to root_path
	      end

	end

	def show
		@users = User.where(approved: 1)
	end

	def edit
	end

	def update
	end

	private
    def user_params
        params.require(:user).permit(:approved)
    end

end
