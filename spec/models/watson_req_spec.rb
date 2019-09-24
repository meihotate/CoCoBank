require 'rails_helper'

RSpec.describe WatsonReq, "モデルに関するテスト", type: :model do
  	describe 'アソシエーション' do
	  	it "Userモデルに属している" do
		      is_expected.to belong_to(:user)
		end
  	end
  	describe '実際に保存してみる' do
  		before do
  			@user = FactoryBot.create(:children)
  		end
	  		context "保存できる場合" do
	  			it "保存できる場合" do
	  				expect(FactoryBot.create(:watson_req, user_id: @user.id)).to be_valid
	  			end
	  		end
	  		context "保存できない場合" do
	  			it "保存できない場合" do
	  				expect(FactoryBot.build(:watson_req, :no_text, user_id: @user.id)).to_not be_valid
	  			end
	  		end
  	end
end
