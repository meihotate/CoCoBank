class ProfileImage < ApplicationRecord

	belongs_to :user
	attachment :profile_image
	validates :user_id, uniqueness: true

end
