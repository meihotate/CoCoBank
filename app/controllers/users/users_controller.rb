class Users::UsersController < ApplicationController

	before_action :admin_signed_in
	before_action :authenticate_user!

	def show
	end

	def edit
	end

	def quit
	end

	def clear
	end

	def index
	end

	def counselor_index
	end

	def detail
	end

end
