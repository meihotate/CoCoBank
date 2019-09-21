require 'rails_helper'

RSpec.describe Users::FriendshipsController, type: :controller do
	describe '友達申請関連' do
		before do
			@user1 = FactoryBot.create(:children)
			@user2 = FactoryBot.create(:children)
		end

		context "友達申請する" do
			before do
				# puts 'test'
				sign_in @user1
				# visit users_detail_path(@user2)
			end
			let(:current_user) {@user1}
			it '友達がcreateされるか' do
				expect {
				post :create, params: {to_user_id: @user2.id}
				}.to change(Friendship, :count).by(1)
				# expect {current_user.request(@user2) }.to change{ Friendship.count }.by(1)
				# expect(Friendship.count).to eq 1
				puts "申請できた？"
			end
		end

		context "友達承認と拒否" do
			before do
				# puts 'test'
				sign_in @user2
				# visit users_show_path(@user2)
				@users = User.where.not(id: current_user.id)
				@friend = Friendship.create(to_user_id: @user2.id, from_user_id: @user1.id, friendstatus: 0)
			end
			let(:current_user) {@user2}
			it "友達承認する&Chatroomの生成" do
				puts @friend
				expect {
				patch :update, params: {from_user_id: @user1.id, table_index: @users.index(@user1)}
				}.to change { Chatroom.count }.by(1).and change { Chatmember.count }.by(2).and change {@friend.reload.friendstatus}.from(0).to(1)
				# current_user.approve_friend(@user1)
				puts @friend.friendstatus
				puts current_user.id
				# expect(@friend.reload.friendstatus).to eq 1
				# expect(Chatroom.count).to eq 1
				# expect(Chatmember.count).to eq 2
			end
			it "拒否する" do
				puts @friend
				expect {
				patch :update_reject, params: {from_user_id: @user1.id, table_index: @users.index(@user1)}
				}.to change {@friend.reload.friendstatus}.from(0).to(2)
				# current_user.reject_friend(@user1)
				puts @friend.friendstatus
				puts current_user.id
				# expect(@friend.reload.friendstatus).to eq 2
			end
		end
	end
end