class Chatmember < ApplicationRecord

	belongs_to :user
	belongs_to :chatroom
	has_many :chatmessages, dependent: :destroy

end
