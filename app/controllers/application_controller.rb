class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_request_from
  # before_action :correct_referer
  rescue_from ActiveRecord::RecordNotFound, with: :back


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

  # def correct_referer
  # 	if request.referer.nil?
  # 		binding.pry
  # 		redirect_to root_path
  # 	end
  # end

  def set_request_from
    if session[:request_from]
    	# binding.pry
      @request_from = session[:request_from]
    end
    # 現在のURLを保存しておく
    # binding.pry
    session[:request_from] = request.original_url
  end

  def back
  	redirect_to @request_from
  end


end
