class Users::ChatroomsController < ApplicationController
  def show
  	chatroom = Chatroom.find(params[:id])
  	@member = Chatmember.find_by(user_id: current_user.id, chatroom_id: chatroom.id)
  	@other_user = User.find(params[:other_user_id])
  	@message = Chatmessage.new

  	if Chatmessage.where(chatroom_id: chatroom.id)
  		@chatmessages = Chatmessage.where(chatroom_id: chatroom.id).order(created_at: :asc)
  	end

  end

  def create
  end
end
