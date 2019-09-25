class Chatmessage < ApplicationRecord

	belongs_to :chatroom
	belongs_to :chatmember

	# Paranoia
  	acts_as_paranoid

end
