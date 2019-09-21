require 'rails_helper'

RSpec.describe Users::RelationshipsController, type: :controller do
	describe 'お気に入り申請関連' do
		before do
			@user1 = FactoryBot.create(:children)
			@user2 = FactoryBot.create(:counselor)
		end
		context "お気に入りするor解除" do
			before do
				puts 'test'
				sign_in @user1
				# visit users_detail_path(@user2)
			end
			let(:current_user) {@user1}
			it 'お気に入りできるか' do
				expect {
				post :create, params: {followed_id: @user2.id}
				}.to change(Relationship, :count).by(1)
				# expect {current_user.request(@user2) }.to change{ Friendship.count }.by(1)
			end
			it 'お気に入り解除' do
				current_user.follow(@user2)
				expect {
				delete :destroy, params: {followed_id: @user2.id}
				}.to change(Relationship, :count).by(-1)
				# expect {current_user.request(@user2) }.to change{ Friendship.count }.by(1)
			end
		end
	end
end