class Chatroom < ApplicationRecord

	has_many :chatmembers, dependent: :destroy
	has_many :chatmessages, dependent: :destroy

  def self.unread?(current_user, other_user)
    chatroom = Chatroom.find_by(id: current_user.chatroom_number(current_user, other_user))
    chatmember = Chatmember.find_by(chatroom_id: chatroom.id, user_id: other_user.id)
    # binding.pry
        if Chatmessage.where(chatroom_id: chatroom.id, chatmember_id: chatmember.id).exists?
          # binding.pry
          lastmessagetime = Chatmessage.where(chatroom_id: chatroom.id, chatmember_id: chatmember.id).last.created_at
          # binding.pry
          lastaccess = chatroom.accesstime
          # binding.pry
            if lastmessagetime > lastaccess
              return true
            else
              return false
            end
        else
          return false
        end
    return false
  end

end
