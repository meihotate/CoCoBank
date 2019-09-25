class Admins::ChatroomsController < ApplicationController
	def show
		@chatroom = Chatroom.find(params[:id])
		@member_id = Chatmember.with_deleted.find_by(user_id: params[:user_id], chatroom_id: @chatroom.id).user_id
		@member = User.with_deleted.find(@member_id)
  		@other_user = User.with_deleted.find(params[:other_user_id])

  		if Chatmessage.with_deleted.where(chatroom_id: @chatroom.id)
  			@chatmessages = Chatmessage.with_deleted.where(chatroom_id: @chatroom.id).order(created_at: :asc)
  			@othermember = Chatmember.with_deleted.find_by(user_id: @other_user.id, chatroom_id: @chatroom.id)
  				@othermember_messages = Chatmessage.with_deleted.where(chatroom_id: @chatroom.id, chatmember_id: @othermember.id)
  			@thismember = Chatmember.with_deleted.find_by(user_id: @member.id, chatroom_id: @chatroom.id)
  				@thismember_messages = Chatmessage.with_deleted.where(chatroom_id: @chatroom.id, chatmember_id: @thismember.id)
  		end
	end
end
