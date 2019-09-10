require 'rails_helper'

RSpec.describe Admins::AdminsController, type: :controller do

  describe 'メールが送信される' do
		before do
			# @user = User.new(name: 'Lucas', email: 'lucas@email.com', sex: 0, location: 0, degree: 0, approved: 1, password: 'password')
			# @user.save
			@admin = FactoryGirl.create(:admin)
			puts @admin
			puts @admin.id
			@user = FactoryGirl.create(:user)
			puts @user
			puts @user.id
		end

		it 'approメソッドにいけるか' do
			# user_params = FactoryGirl.attributes_for(:user, approved: 2)
			sign_in @admin
			user_params = {:approved=> 2}
			patch :appro, params: {user_id: @user.id, user: user_params}
			expect(@user.reload.approved).to eq 2
			puts 'test'
		# 	expect { user.welcome_email }.to change { ActionMailer::Base.deliveries.count }.by(1)
		end
  end

end