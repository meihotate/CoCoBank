class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
  	Chatmessage.create!( chatroom_id: data['chatroom_id'], chatmember_id: data['chatmember_id'], message: data['message'])
  	ActionCable.server.broadcast 'room_channel', message: data['message'], current_user_id: data['current_user_id'], chatroom_id: data['chatroom_id']
  end
end
