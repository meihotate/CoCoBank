class Users::UsersController < ApplicationController

	before_action :admin_signed_in
	before_action :authenticate_user!

	def show
		@user = current_user
		@users = User.where.not(id: current_user.id)
		@friends1 = Friendship.where(friendstatus: 1, to_user_id: @user.id)
		@friends2 = Friendship.where(friendstatus: 1, from_user_id: @user.id)

		if @user.profile_image
			@profile_image = ProfileImage.find_by(user_id: @user.id)
		else
			@profile_image = ProfileImage.new
		end

		# gon(性格診断チャート)
		if @user.watson_req
			# 五大個性(ラベル)
			gon.big5_title = "５大個性"
			# 五大個性(数値)
			@big5_openness = @user.watson_req.big5_openness * 100
			@big5_conscientiousness = @user.watson_req.big5_conscientiousness * 100
			@big5_extraversion = @user.watson_req.big5_extraversion * 100
			@big5_agreeableness = @user.watson_req.big5_agreeableness * 100
			@big5_neuroticism = @user.watson_req.big5_neuroticism * 100
				gon.big5_values = [@big5_openness, @big5_conscientiousness, @big5_extraversion, @big5_agreeableness, @big5_neuroticism]
			# 五大個性(名前)
			@big5_openness_name = @user.watson_req.big5_openness_name
			@big5_conscientiousness_name = @user.watson_req.big5_conscientiousness_name
			@big5_extraversion_name = @user.watson_req.big5_extraversion_name
			@big5_agreeableness_name = @user.watson_req.big5_agreeableness_name
			@big5_neuroticism_name = @user.watson_req.big5_neuroticism_name
				gon.big5_labels = [@big5_openness_name, @big5_conscientiousness_name, @big5_extraversion_name, @big5_agreeableness_name, @big5_neuroticism_name]
			# 12欲求(ラベル)
			gon.need_title = "深層欲求"
			# 12欲求(数値)
			@need_challenge = @user.watson_req.need_challenge * 100
			@need_closeness = @user.watson_req.need_closeness * 100
			@need_curiosity = @user.watson_req.need_curiosity * 100
			@need_excitement = @user.watson_req.need_excitement * 100
			@need_harmony = @user.watson_req.need_harmony * 100
			@need_ideal = @user.watson_req.need_ideal * 100
			@need_liberty = @user.watson_req.need_liberty * 100
			@need_love = @user.watson_req.need_love * 100
			@need_practicality = @user.watson_req.need_practicality * 100
			@need_self_expression = @user.watson_req.need_self_expression * 100
			@need_stability = @user.watson_req.need_stability * 100
			@need_structure = @user.watson_req.need_structure * 100
				gon.need_values = [@need_challenge, @need_closeness, @need_curiosity, @need_excitement, @need_harmony, @need_ideal, @need_liberty, @need_love, @need_practicality, @need_self_expression, @need_stability, @need_structure]
			# 12欲求(名前)
			@need_challenge_name = @user.watson_req.need_challenge_name
			@need_closeness_name = @user.watson_req.need_closeness_name
			@need_curiosity_name = @user.watson_req.need_curiosity_name
			@need_excitement_name = @user.watson_req.need_excitement_name
			@need_harmony_name = @user.watson_req.need_harmony_name
			@need_ideal_name = @user.watson_req.need_ideal_name
			@need_liberty_name = @user.watson_req.need_liberty_name
			@need_love_name = @user.watson_req.need_love_name
			@need_practicality_name = @user.watson_req.need_practicality_name
			@need_self_expression_name = @user.watson_req.need_self_expression_name
			@need_stability_name = @user.watson_req.need_stability_name
			@need_structure_name = @user.watson_req.need_structure_name
				gon.need_labels = [@need_challenge_name, @need_closeness_name, @need_curiosity_name, @need_excitement_name, @need_harmony_name, @need_ideal_name, @need_liberty_name, @need_love_name, @need_practicality_name, @need_self_expression_name, @need_stability_name, @need_structure_name]
			# 五大価値観(ラベル)
			gon.value_title = "５大価値観"
			# 五大価値観(数値)
			@value_conservation = @user.watson_req.value_conservation * 100
			@value_openness_to_change = @user.watson_req.value_openness_to_change * 100
			@value_hedonism = @user.watson_req.value_hedonism * 100
			@value_self_enhancement = @user.watson_req.value_self_enhancement * 100
			@value_self_transcendence = @user.watson_req.value_self_transcendence * 100
				gon.value_values = [@value_conservation, @value_openness_to_change, @value_hedonism, @value_self_enhancement, @value_self_transcendence]
			# 五大価値観(名前)
			@value_conservation_name = @user.watson_req.value_conservation_name
			@value_openness_to_change_name = @user.watson_req.value_openness_to_change_name
			@value_hedonism_name = @user.watson_req.value_hedonism_name
			@value_self_enhancement_name = @user.watson_req.value_self_enhancement_name
			@value_self_transcendence_name = @user.watson_req.value_self_transcendence_name
				gon.value_labels = [@value_conservation_name, @value_openness_to_change_name, @value_hedonism_name, @value_self_enhancement_name, @value_self_transcendence_name]
		end

	end

	def edit
		@user = current_user
	end

	def update
		@user = current_user
		if @user.update(user_params)
			flash[:notice] = "正常に更新されました"
			redirect_to users_show_path(current_user)
		else
			render :edit
		end
	end

	def quit
	end

	def clear
	end

	def index
		@users = User.where.not(id: current_user.id)
	end

	def counselor_index
		@users = User.where.not(id: current_user.id)
	end

	def detail
		@user = User.find(params[:user_id])
	end

	private
    def user_params
        params.require(:user).permit(:email, :name, :sex, :location, :degree, :introduction)
    end

end
