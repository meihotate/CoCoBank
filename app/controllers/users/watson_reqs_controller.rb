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
		watson_url = 'https://gateway.watsonplatform.net/personality-insights/api/v3/profile?version=2017-10-13'
		token = "eyJraWQiOiIyMDE5MDUxMyIsImFsZyI6IlJTMjU2In0.eyJpYW1faWQiOiJpYW0tU2VydmljZUlkLWQ2MTBjMDYzLTRiNTctNGFiZS1hZjJjLTFmMmJiN2E2OWU2YiIsImlkIjoiaWFtLVNlcnZpY2VJZC1kNjEwYzA2My00YjU3LTRhYmUtYWYyYy0xZjJiYjdhNjllNmIiLCJyZWFsbWlkIjoiaWFtIiwiaWRlbnRpZmllciI6IlNlcnZpY2VJZC1kNjEwYzA2My00YjU3LTRhYmUtYWYyYy0xZjJiYjdhNjllNmIiLCJzdWIiOiJTZXJ2aWNlSWQtZDYxMGMwNjMtNGI1Ny00YWJlLWFmMmMtMWYyYmI3YTY5ZTZiIiwic3ViX3R5cGUiOiJTZXJ2aWNlSWQiLCJ1bmlxdWVfaW5zdGFuY2VfY3JucyI6WyJjcm46djE6Ymx1ZW1peDpwdWJsaWM6cGVyc29uYWxpdHktaW5zaWdodHM6dXMtc291dGg6YS9lYTE0NTRhNTNmOWY0YmFkOTQ3MGRmMWVhNGU1YTNjZDo5ZWY3YmUwMy02NzI1LTQ3ZWUtYWM5Yy1mMTE0YWYzNjYwYTc6OiJdLCJhY2NvdW50Ijp7InZhbGlkIjp0cnVlLCJic3MiOiJlYTE0NTRhNTNmOWY0YmFkOTQ3MGRmMWVhNGU1YTNjZCJ9LCJpYXQiOjE1NjgyNzQzNjEsImV4cCI6MTU2ODI3Nzk2MSwiaXNzIjoiaHR0cHM6Ly9pYW0uYmx1ZW1peC5uZXQvaWRlbnRpdHkiLCJncmFudF90eXBlIjoidXJuOmlibTpwYXJhbXM6b2F1dGg6Z3JhbnQtdHlwZTphcGlrZXkiLCJzY29wZSI6ImlibSBvcGVuaWQiLCJjbGllbnRfaWQiOiJieCIsImFjciI6MSwiYW1yIjpbInB3ZCJdfQ.CWOcbsJ4eLHJimfA17t6DbAZxmKnVkIZlKdmY3lt43fGWV-B9EzBtRjOAqui6eg_kU5JA4jK_qyxGuRmFj372xq7gZHW2AHXEGJLemY4oOwY3FqkV3LFOAZHY_ulD-ep9wNe_i-ejFy3HTl__YxibUyEeY_Uws-Ub6FNg6KhUCXroFpn8kZhfQxOjnJ1r5gOubE3KRHT9UiOSDqCpycnWkAftngZBTXc8KgOA2T7e17rBQM-Yfch5JFW13neNrcH-vbKTpAnw6WibpOvyU0Wiy088JE8X0B7FS_whxJJkKVrgIfOvEY0p45_Cg2n_0ZhNLb7AxGPCtDGtUZDcnSBqg"

		uri = URI.parse(watson_url)
		http = Net::HTTP.new(uri.host, uri.port)

		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE

		req = Net::HTTP::Post.new(uri)
		req.basic_auth("apikey", "RcYeE5GDP6kbmpoxHA8ZEY4dVTfj9GVb2zdzRZTev9jh")
		req["Content-Type"] = "text/plain;charset=utf-8"
		req["Accept"] = "application/json"
		req["Content-Language"] = "ja"
		req["Accept-Language"] = "ja"
		# req["Authorization"] = "Bearer #{token}"

		data = text
		req.body = data
		res = http.request(req)

		puts res.body
		result = JSON.parse(res.body)
		puts result

		params[:watson_req][:big5_openness_name] = result['personality'][0]['name']
		params[:watson_req][:big5_openness] = result['personality'][0]['percentile']
		params[:watson_req][:big5_conscientiousness_name] = result['personality'][1]['name']
		params[:watson_req][:big5_conscientiousness] = result['personality'][1]['percentile']
		params[:watson_req][:big5_extraversion_name] = result['personality'][2]['name']
		params[:watson_req][:big5_extraversion] = result['personality'][2]['percentile']
		params[:watson_req][:big5_agreeableness_name] = result['personality'][3]['name']
		params[:watson_req][:big5_agreeableness] = result['personality'][3]['percentile']
		params[:watson_req][:big5_neuroticism_name] = result['personality'][4]['name']
		params[:watson_req][:big5_neuroticism] = result['personality'][4]['percentile']

		params[:watson_req][:need_challenge_name] = result['needs'][0]['name']
		params[:watson_req][:need_challenge] = result['needs'][0]['percentile']
		params[:watson_req][:need_closeness_name] = result['needs'][1]['name']
		params[:watson_req][:need_closeness] = result['needs'][1]['percentile']
		params[:watson_req][:need_curiosity_name] = result['needs'][2]['name']
		params[:watson_req][:need_curiosity] = result['needs'][2]['percentile']
		params[:watson_req][:need_excitement_name] = result['needs'][3]['name']
		params[:watson_req][:need_excitement] = result['needs'][3]['percentile']
		params[:watson_req][:need_harmony_name] = result['needs'][4]['name']
		params[:watson_req][:need_harmony] = result['needs'][4]['percentile']
		params[:watson_req][:need_ideal_name] = result['needs'][5]['name']
		params[:watson_req][:need_ideal] = result['needs'][5]['percentile']
		params[:watson_req][:need_liberty_name] = result['needs'][6]['name']
		params[:watson_req][:need_liberty] = result['needs'][6]['percentile']
		params[:watson_req][:need_love_name] = result['needs'][7]['name']
		params[:watson_req][:need_love] = result['needs'][7]['percentile']
		params[:watson_req][:need_practicality_name] = result['needs'][8]['name']
		params[:watson_req][:need_practicality] = result['needs'][8]['percentile']
		params[:watson_req][:need_self_expression_name] = result['needs'][9]['name']
		params[:watson_req][:need_self_expression] = result['needs'][9]['percentile']
		params[:watson_req][:need_stability_name] = result['needs'][10]['name']
		params[:watson_req][:need_stability] = result['needs'][10]['percentile']
		params[:watson_req][:need_structure_name] = result['needs'][11]['name']
		params[:watson_req][:need_structure] = result['needs'][11]['percentile']

		params[:watson_req][:value_conservation_name] = result['values'][0]['name']
		params[:watson_req][:value_conservation] = result['values'][0]['percentile']
		params[:watson_req][:value_openness_to_change_name] = result['values'][1]['name']
		params[:watson_req][:value_openness_to_change] = result['values'][1]['percentile']
		params[:watson_req][:value_hedonism_name] = result['values'][2]['name']
		params[:watson_req][:value_hedonism] = result['values'][2]['percentile']
		params[:watson_req][:value_self_enhancement_name] = result['values'][3]['name']
		params[:watson_req][:value_self_enhancement] = result['values'][3]['percentile']
		params[:watson_req][:value_self_transcendence_name] = result['values'][4]['name']
		params[:watson_req][:value_self_transcendence] = result['values'][4]['percentile']

		@watsonreq = WatsonReq.new(request_params)


		if @watsonreq.save
			redirect_to users_show_path(current_user)
		else
			render :new
		end
	end

	def show
	end

	def edit
	end

	def update
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
