class Chatmember < ApplicationRecord

	belongs_to :user
	belongs_to :chatroom

	# Paranoia
  	acts_as_paranoid

	has_many :chatmessages, dependent: :destroy

end
