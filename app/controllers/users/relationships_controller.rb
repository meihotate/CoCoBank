class Users::RelationshipsController < ApplicationController

	def create
		@user = User.find(params[:followed_id])
		current_user.follow(@user)
		respond_to do |format|
			format.html { redirect_to users_detail_path(@user) }
			format.js
		end
	end

	def destroy
		@user = Relationship.find_by(followed_id: params[:followed_id], follower_id: current_user.id).followed
		current_user.unfollow(@user)
		respond_to do |format|
			format.html { redirect_to users_detail_path(@user) }
			format.js
		end
	end

end
