class Users::UsersController < ApplicationController

	before_action :admin_signed_in
	before_action :authenticate_user!

	def show
		@user = current_user
		@users = User.where.not(id: current_user.id)
		if @user.profile_image
			# binding.pry
			@profile_image = ProfileImage.find_by(user_id: @user.id)
		else
			@profile_image = ProfileImage.new
		end
	end

	def edit
	end

	def quit
	end

	def clear
	end

	def index
		@users = User.where.not(id: current_user.id)
	end

	def counselor_index
		@users = User.where.not(id: current_user.id)
	end

	def detail
		@user = User.find(params[:user_id])
	end

end
