class Friendship < ApplicationRecord
	belongs_to :to_user, class_name: "User"
	belongs_to :from_user, class_name: "User"

	# Paranoia
  	acts_as_paranoid
  	
	validates :to_user_id, presence: true
	validates :from_user_id, presence: true

end
