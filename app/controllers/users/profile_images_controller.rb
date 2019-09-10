class Users::ProfileImagesController < ApplicationController

	def create
		@image = ProfileImage.new(image_params)
		      if @image.save
		        flash[:notice] = "プロフィール画像は保存されました。"
		        redirect_to users_show_path(params[:profile_image][:user_id])
		      else
		      	render "users/users/show"
		      end
	end

	def update
		@image = ProfileImage.find_by(params[:profile_image][:user_id])
			if @image.update(image_params)
		        flash[:notice] = "プロフィール画像は更新されました。"
				redirect_to users_show_path(params[:profile_image][:user_id])
			else
				render "users/users/show"
		    end
	end

	private
    def image_params
    	params.require(:profile_image).permit(:user_id, :profile_image)
    end

end
