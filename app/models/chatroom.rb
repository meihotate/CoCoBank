class Chatroom < ApplicationRecord

	has_many :chatmembers, dependent: :destroy
	has_many :chatmessages, dependent: :destroy

end
