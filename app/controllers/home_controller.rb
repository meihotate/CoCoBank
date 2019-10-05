class HomeController < ApplicationController

	def top
		if user_signed_in?
			user = User.find(current_user.id)
			if user.approved == 1
				flash[:notice] = "カウンセラーとして承認されるまで今しばらくお待ちください。"
			end
		end
	end

	def about
	end

end
