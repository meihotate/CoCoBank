class Users::FriendshipsController < ApplicationController

	def create
		@user = User.find(params[:to_user_id])
		current_user.request(@user)
		respond_to do |format|
			format.html { redirect_to users_detail_path(@user) }
			format.js
		end
	end

	def update
		@user = User.find(params[:from_user_id])
		current_user.approve_friend(@user)
		@table_index = params[:table_index]

		# チャットルームの生成
		room = Chatroom.create(title: "#{@user.name}さんと#{current_user.name}さんのチャットルーム")
		# チャット
		Chatmember.create(chatroom_id: room.id, user_id: current_user.id)
		Chatmember.create(chatroom_id: room.id, user_id: @user.id)

		# redirect_to users_show_path(current_user)
		respond_to do |format|
			format.html { redirect_to users_show_path(current_user) }
			format.js
		end
	end

	def update_reject
		@user = User.find(params[:from_user_id])
		current_user.reject_friend(@user)
		@table_index = params[:table_index]
		# binding.pry
		# redirect_to users_show_path(current_user)
		respond_to do |format|
			format.html { redirect_to users_show_path(current_user) }
			format.js
		end
	end

	def second_update
		@user = User.find(params[:from_user_id])
		current_user.approve_friend(@user)
		# チャットルームの生成
		room = Chatroom.create(title: "#{@user.name}さんと#{current_user.name}さんのチャットルーム")
		# チャット
		Chatmember.create(chatroom_id: room.id, user_id: current_user.id)
		Chatmember.create(chatroom_id: room.id, user_id: @user.id)
		# redirect_to users_show_path(current_user)
		respond_to do |format|
			format.html { redirect_to users_detail_path(@user) }
			format.js
		end
	end

end
