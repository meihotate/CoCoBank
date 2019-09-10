class Chatmessage < ApplicationRecord

	belongs_to :chatroom
	belongs_to :chatmember

end
