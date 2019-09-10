class Users::FriendshipsController < ApplicationController

	def create
	    user = User.find(params[:to_user_id])
	    current_user.request(user)
	    # user.save
	    redirect_to users_detail_path(user)
  	end

	def update
		user = User.find(params[:from_user_id])
		current_user.approve_friend(user)

		# チャットルームの生成
		room = Chatroom.create(title: "#{user.name}さんと#{current_user.name}さんのチャットルーム")
		# チャット
		Chatmember.create(chatroom_id: room.id, user_id: current_user.id)
		Chatmember.create(chatroom_id: room.id, user_id: user.id)

		redirect_to users_show_path(current_user)
	end

	def update_reject
		user = User.find(params[:from_user_id])
		current_user.reject_friend(user)
		redirect_to users_show_path(current_user)
	end

end
