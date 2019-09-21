require 'rails_helper'

RSpec.describe Admins::AdminsController, type: :controller do

  # describe 'メールが送信される' do
		# before do
		# 	# @user = User.new(name: 'Lucas', email: 'lucas@email.com', sex: 0, location: 0, degree: 0, approved: 1, password: 'password')
		# 	# @user.save
		# 	@admin = FactoryBot.create(:admin)
		# 	puts @admin
		# 	puts @admin.id
		# 	@user = FactoryBot.create(:user)
		# 	puts @user
		# 	puts @user.id
		# end

		# it 'approメソッドにいけるか' do
		# 	# user_params = FactoryGirl.attributes_for(:user, approved: 2)
		# 	sign_in @admin
		# 	user_params = {:approved=> 2}
		# 	patch :appro, params: {user_id: @user.id, user: user_params}
		# 	expect(@user.reload.approved).to eq 2
		# 	puts 'test'
		# # 	expect { user.welcome_email }.to change { ActionMailer::Base.deliveries.count }.by(1)
		# end
  # end
	describe 'カウンセラー承認される' do
		  before do
		  	@admin = FactoryBot.create(:admin)
		  	@user = FactoryBot.create(:user)
		  	@user_params = {:approved=> 2}
		  end
		  	let(:mail) { UserMailer.with(user: @user).welcome_email }

		  it 'approメソッドでuser updateされるか' do
		  	sign_in @admin
		  	patch :appro, params: {user_id: @user.id, user: @user_params}
		  	expect(@user.reload.approved).to eq 2
		  	puts @admin
		  	puts @user
		  end

		  it '承認メール送信されるか' do
			  expect do
		        mail.deliver
		      end.to change { ActionMailer::Base.deliveries.size }.by(1)
		  end
	end

end