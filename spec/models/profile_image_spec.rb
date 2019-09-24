require 'rails_helper'
require "refile/file_double"

RSpec.describe ProfileImage, "モデルに関するテスト", type: :model do
	describe 'アソシエーション' do
	    it "Userモデルに属している" do
	      is_expected.to belong_to(:user)
	    end
  	end
  	describe '実際に保存してみる' do
  		context "保存できる場合" do
  			it "user_idを入れて保存" do
        		user = FactoryBot.create(:children)
        		puts user
        		expect(FactoryBot.create(:profile_image, user_id: user.id)).to be_valid
      		end
  		end
  		context "保存できない場合" do
  			it "user_idがない場合" do
        		expect(FactoryBot.build(:profile_image)).to_not be_valid
      		end
  		end
  	end
end