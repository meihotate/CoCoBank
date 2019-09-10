class Chatroom < ApplicationRecord

	has_many :chatmembers, dependent: :destroy
	has_many :chatmessages, dependent: :destroy

  # # chatmemberのidを検索
  # def chatroom_member(id, current_user)
  #   array = Chatmember.where(chatroom_id: id).map {|member| member.user_id}
  #   	if array[0] == current_user.id

  #   array2 = Chatmember.where(user_id: other_user.id).map {|member| member.chatroom_id}
  #   array = array1 & array2
  #   return room_number = array[0].to_i
  # end

end
