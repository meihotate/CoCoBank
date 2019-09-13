class WatsonReq < ApplicationRecord
	belongs_to :user
	has_one :watson_result, dependent: :destroy
end
