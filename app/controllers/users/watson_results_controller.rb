class Users::WatsonResultsController < ApplicationController

require 'net/https'
require 'uri'
require 'json'

	def show

	end

	def create
		watson_url = 'https://gateway.watsonplatform.net/personality-insights/api/v3/profile?version=2017-10-13'

		uri = URI.parse(watson_url)
		http = Net::HTTP.new(uri.host, uri.port)

		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE

		req = Net::HTTP::Post.new(uri)
		req.basic_auth("apikey", ENV['API_KEY'])
		req["Content-Type"] = "text/plain;charset=utf-8"
		req["Accept"] = "application/json"
		# req["Authorization"] = "Bearer #{token}"

		data = <<-EOF
		EOF

		req.body = data
		res = http.request(req)

		puts res.body
		result = JSON.parse(res.body)
		puts result

		redirect_to users_show_path(current_user)

	end

end
