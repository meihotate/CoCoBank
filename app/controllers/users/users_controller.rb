class Users::UsersController < ApplicationController

	before_action :admin_signed_in
	before_action :authenticate_user!

	def show
		if current_user.id == params[:id].to_i
			@user = current_user
			@users = User.where.not(id: current_user.id)
			# @friends1 = Friendship.where(friendstatus: 1, to_user_id: @user.id)
			# @friends2 = Friendship.where(friendstatus: 1, from_user_id: @user.id)
			@all_friends = current_user.all_friends(@user)
			if @user.profile_image
				@profile_image = ProfileImage.find_by(user_id: @user.id)
			else
				@profile_image = ProfileImage.new
			end
			@user.watson_chart(@user, gon)
		else
			redirect_to users_show_path(current_user)
		end
	end

	def edit
		@user = current_user
	end

	def update
		@user = current_user
		if @user.update(user_params)
			flash[:notice] = "正常に更新されました"
			redirect_to users_show_path(current_user)
		else
			render :edit
		end
	end

	def quit
	end

	def destroy
		@user = current_user
		email = @user.email
		nowtime = DateTime.now.to_s
		@user.update(email: email + nowtime)
		@user.destroy
		redirect_to root_path
	end

	def index
		@users = User.where.not(id: current_user.id)
	end

	def counselor_index
		@users = User.where.not(id: current_user.id)
	end

	def detail
		@user1 = current_user
		@all_friends = current_user.all_friends(@user1)
		if User.find(params[:user_id])
			@user = User.find(params[:user_id])
			@current_user = current_user
			@friends1 = Friendship.where(friendstatus: 1, to_user_id: current_user.id)
			@friends2 = Friendship.where(friendstatus: 1, from_user_id: current_user.id)
			@user.watson_chart(@user, gon)
		else
			redirect_to users_show_path(current_user)
		end
	end

	private
    def user_params
        params.require(:user).permit(:email, :name, :sex, :location, :degree, :introduction)
    end

end
