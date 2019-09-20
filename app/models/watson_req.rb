class WatsonReq < ApplicationRecord
	belongs_to :user
	has_one :watson_result, dependent: :destroy

	validates :text1, presence: true
	validates :text2, presence: true
	validates :text3, presence: true
	validates :text4, presence: true
	validates :text5, presence: true
	validates :text6, presence: true
	validates :text7, presence: true
	validates :text8, presence: true
	validates :text9, presence: true
	validates :text10, presence: true

	def self.request_watson(text,params)
		watson_url = 'https://gateway.watsonplatform.net/personality-insights/api/v3/profile?version=2017-10-13'
				uri = URI.parse(watson_url)
				http = Net::HTTP.new(uri.host, uri.port)
				http.use_ssl = true
				http.verify_mode = OpenSSL::SSL::VERIFY_NONE

				req = Net::HTTP::Post.new(uri)
				req.basic_auth("apikey", ENV['API_KEY'])
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
	end

end
