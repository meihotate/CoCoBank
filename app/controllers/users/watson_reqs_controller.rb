class Users::WatsonReqsController < ApplicationController

	before_action :admin_signed_in
	before_action :authenticate_user!

	require 'net/https'
	require 'uri'
	require 'json'

	def new
		@watsonreq = WatsonReq.new
	end

	def create
		text = params[:watson_req][:text1] + params[:watson_req][:text2] + params[:watson_req][:text3] + params[:watson_req][:text4] + params[:watson_req][:text4] + params[:watson_req][:text5] + params[:watson_req][:text6] + params[:watson_req][:text7] + params[:watson_req][:text8] + params[:watson_req][:text9] + params[:watson_req][:text10]
		if text.length >= 100
				message = WatsonReq.request_watson(text,params)
				if message == '成功'
					@watsonreq = WatsonReq.new(request_params)
					if @watsonreq.save
						flash[:notice] = "正常に性格診断を行いました"
						redirect_to users_show_path(current_user)
					else
						flash[:notice] = "性格診断に失敗しました"
						@watsonreq = WatsonReq.new
						render :new
					end
				else
					@watsonreq = WatsonReq.new
					flash[:notice] = message
					render :new
				end
		else
				@watsonreq = WatsonReq.new
				unless @watsonreq.save
					flash[:notice] = "合計100文字以上入力してください"
					render :new
				end
		end
	end

	def show
	end

	def edit
		@user = current_user
		@watsonreq = WatsonReq.find(params[:id])
	end

	def update
		@watsonreq = WatsonReq.find(params[:id])
		@user = current_user
		text = params[:watson_req][:text1] + params[:watson_req][:text2] + params[:watson_req][:text3] + params[:watson_req][:text4] + params[:watson_req][:text4] + params[:watson_req][:text5] + params[:watson_req][:text6] + params[:watson_req][:text7] + params[:watson_req][:text8] + params[:watson_req][:text9] + params[:watson_req][:text10]
		if text.length >= 100
			message = WatsonReq.request_watson(text,params)
			if message == '成功'
				if @watsonreq.update(request_params)
					flash[:notice] = "正常に性格診断を行いました"
					redirect_to users_show_path(current_user)
				else
					flash[:notice] = "性格診断に失敗しました"
					render :edit
				end
			else
				flash[:notice] = message
				render :edit
			end
		else
			unless @watsonreq.update
				flash[:notice] = "合計100文字以上入力してください"
				render :edit
			end
		end
	end

	def index
		redirect_to new_users_watson_req_path
	end

	private
    def request_params
        params.require(:watson_req).permit(
        	:user_id, :text1, :text2, :text3, :text4, :text5, :text6, :text7, :text8, :text9,
        	:text10, :big5_openness_name, :big5_openness, :big5_conscientiousness_name, :big5_conscientiousness, :big5_extraversion_name,
        	:big5_extraversion, :big5_agreeableness_name, :big5_agreeableness, :big5_neuroticism_name, :big5_neuroticism,
        	:need_challenge_name, :need_challenge, :need_closeness_name, :need_closeness, :need_curiosity_name, :need_curiosity,
        	:need_excitement_name, :need_excitement, :need_harmony_name, :need_harmony, :need_ideal_name, :need_ideal,
        	:need_liberty_name, :need_liberty, :need_love_name, :need_love, :need_practicality_name, :need_practicality, :need_self_expression_name,
        	:need_self_expression, :need_stability_name, :need_stability, :need_structure_name, :need_structure,
        	:value_conservation_name, :value_conservation, :value_openness_to_change_name, :value_openness_to_change,
        	:value_hedonism_name, :value_hedonism, :value_self_enhancement_name, :value_self_enhancement, :value_self_transcendence_name,
        	:value_self_transcendence
        	)
    end


end
