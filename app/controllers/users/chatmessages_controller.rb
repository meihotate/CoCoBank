class Users::ChatmessagesController < ApplicationController

	def create
		chatroom = Chatroom.find(params[:chatmessage][:chatroom_id])
		@message = Chatmessage.new(message_params)
		if @message.save
			redirect_to users_chatroom_path(id: chatroom.id, other_user_id: params[:other_user_id])
		else
			redirect_to users_chatroom_path(id: chatroom.id, other_user_id: params[:other_user_id])
		end
	end

	private
	def message_params
		params.require(:chatmessage).permit(:message, :chatmember_id, :chatroom_id)
	end

end
