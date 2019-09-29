class Users::ProfileImagesController < ApplicationController

	def create
		@profile_image = ProfileImage.new(image_params)
		@user = current_user
		      if @profile_image.save
		        @image_src = Refile.attachment_url(@profile_image, :profile_image)
		        # binding.pry
		        # redirect_to users_show_path(params[:profile_image][:user_id])
		        respond_to do |format|
	      			format.html { redirect_to users_show_path(params[:profile_image][:user_id]) }
	      			format.js
	    		end
		      else
		      	@image_src = '/images/no_image.jpg'
		      	@user = current_user
		      	@users = User.where.not(id: current_user.id)
				@friends1 = Friendship.where(friendstatus: 1, to_user_id: @user.id)
				@friends2 = Friendship.where(friendstatus: 1, from_user_id: @user.id)
		      	# render "users/users/show"
		  		respond_to do |format|
	      			format.html { render "users/users/show" }
	      			format.js
	      		end
		      end
	end

	def update
		@profile_image = ProfileImage.find_by(user_id: params[:profile_image][:user_id])
		@oldimage_src = Refile.attachment_url(@profile_image, :profile_image)
			if @profile_image.update(image_params)
		        @image_src = Refile.attachment_url(@profile_image, :profile_image)
				# redirect_to users_show_path(params[:profile_image][:user_id])
				respond_to do |format|
	      			format.html { redirect_to users_show_path(params[:profile_image][:user_id]) }
	      			format.js
	    		end
			else
				@image_src = Refile.attachment_url(@profile_image, :profile_image)
				@user = current_user
		      	@users = User.where.not(id: current_user.id)
		      	@all_friends = current_user.all_friends(@user)
		      	if @user.profile_image
					@profile_image = ProfileImage.find_by(user_id: @user.id)
				else
					@profile_image = ProfileImage.new
				end
				@user.watson_chart(@user, gon)
				@friends1 = Friendship.where(friendstatus: 1, to_user_id: @user.id)
				@friends2 = Friendship.where(friendstatus: 1, from_user_id: @user.id)
	     	  	render "users/users/show"
		    end
	end

	private
    def image_params
    	params.require(:profile_image).permit(:user_id, :profile_image)
    end

end
