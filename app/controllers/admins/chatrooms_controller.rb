class Admins::ChatroomsController < ApplicationController
	def show
		@chatroom = Chatroom.find(params[:id])
		@member = Chatmember.find_by(user_id: params[:user_id], chatroom_id: @chatroom.id).user
  		@other_user = User.find(params[:other_user_id])

  		if Chatmessage.where(chatroom_id: @chatroom.id)
  			@chatmessages = Chatmessage.where(chatroom_id: @chatroom.id).order(created_at: :asc)
  		end
	end
end
