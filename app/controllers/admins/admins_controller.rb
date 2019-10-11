class Admins::AdminsController < ApplicationController

	before_action :user_signed_in
	before_action :authenticate_admin!

	def appro
		@user = User.find(params[:user_id])
		if @user.update(approved: 2)
			# 保存後にUserMailerを使ってwelcomeメールを送信
			UserMailer.with(user: @user).welcome_email.deliver
			flash[:notice] = "承認メールを送信しました。"
			redirect_to admins_admin_path(current_admin)
		else
			redirect_to admins_admin_path(current_admin)
		end
	end

	def reject
		@user = User.find(params[:user_id])
		if @user.update(approved: 3)
			# 保存後にUserMailerを使ってwelcomeメールを送信
			UserMailer.with(user: @user).reject_email.deliver
			flash[:notice] = "不採用メールを送信しました。"
			redirect_to admins_admin_path(current_admin)
		else
			redirect_to admins_admin_path(current_admin)
		end
	end

	def show
		@users = User.where(approved: 1)
		@admin = Admin.find(params[:id])
	end

	def edit
	end

	def update
	@admin = current_admin
	if @admin.update(admin_params)
		respond_to do |format|
			format.html { redirect_to admins_admin_path(current_admin) }
			format.js
		end
	else
		@users = User.where(approved: 1)
		flash[:notice] = "新しい情報を入力してください"
		format.html { render "admins/admins/show" }
	end
	end

	def index
		@users = User.with_deleted.where(approved: 0)
	end

	def counselor_index
		@counselors = User.with_deleted.where(approved: 2)
	end

	def detail
			@user = User.with_deleted.find(params[:user_id])
			@user.watson_chart(@user, gon)
				if Chatmember.where(user_id: @user.id)
					@chatrooms = Chatmember.with_deleted.where(user_id: @user.id).map() { |chatmember| chatmember.chatroom_id }
					@chatmembers = Chatmember.with_deleted.where.not(user_id: @user.id)
				end
	end

	def destroy
		@user = User.find(params[:user_id])
		email = @user.email
		nowtime = DateTime.now.to_s
		@user.update(email: email + nowtime)
		@user.destroy
		flash[:notice] = "ユーザーを退会させました"
		redirect_to root_path
	end

	def restore
		@user = User.with_deleted.find(params[:user_id])
		email = @user.email
		if @user.restore(:recursive => true)
			email.slice!(/\d\d\d\d[-]\d\d[-]\d\d[t]\d\d[:]\d\d[:]\d\d[+]\d\d[:]\d\d/)
			@user.update(email: email)
			flash[:notice] = "ユーザーを再入会させました"
			redirect_to admins_admin_user_detail_path(@user)
		else
			@user.watson_chart(@user, gon)
				if Chatmember.where(user_id: @user.id)
					@chatrooms = Chatmember.with_deleted.where(user_id: @user.id).map() { |chatmember| chatmember.chatroom_id }
					@chatmembers = Chatmember.with_deleted.where.not(user_id: @user.id)
				end
			flash[:notice] = "ユーザーの再入会プロセスに失敗しました"
			render :detail
		end
	end

	private
	def user_params
		params.require(:user).permit(:approved)
	end

	def admin_params
		params.require(:admin).permit(:email, :name)
	end

end
