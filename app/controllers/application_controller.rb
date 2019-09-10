class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?




  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :sex, :location, :approved])
  end

  def user_signed_in
		if user_signed_in?
			# binding.pry
			flash[:notice] = "ユーザーでログインしています。一度ログアウトしてください"
			redirect_to root_path
		end
  end

  def admin_signed_in
		if admin_signed_in?
			# binding.pry
			flash[:notice] = "管理者でログインしています。一度ログアウトしてください"
			redirect_to root_path
		end
  end

end
