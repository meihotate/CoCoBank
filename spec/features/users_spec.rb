require 'rails_helper'

RSpec.feature "Userに関するテスト", type: :feature do
	before do
		@user1 = FactoryBot.create(:children)
	end
	feature "ログインした状態で" do
		before do
      		login_as(@user1, :scope => :user, :run_callbacks => false)
    	end
			feature "自分のプロフィールの更新" do
				before do
					visit users_editing_path
					puts current_path
				end
					feature "正しく更新できる場合" do
						before do
					        find_field('user[email]').set('updated_email@test.com')
					        find_field('user[name]').set('updated_name')
					        find_field('user[introduction]').set('updated_inttroduction')
					        select('男性', from: 'user[sex]')
					        select('東京都', from: 'user[location]')
					        select('中１', from: 'user[degree]')
					        find("input[name='commit']").click
					    end
					    let(:current_user) {@user1}
					    scenario "userが更新されているか" do
					        expect(@user1.reload.name).to eq "updated_name"
					        expect(page).to have_content "正常に更新されました"
					    end
						scenario "正しくリダイレクトされるか" do
					    	# puts current_path
							expect(page).to have_current_path users_show_path(@user1)
						end
					end
					feature "正しく更新できない場合" do
						before do
					        find_field('user[email]').set('updated_emailtest.com')
					        find_field('user[name]').set(nil)
					        find_field('user[introduction]').set(:too_long_introduction)
					        select('男性', from: 'user[sex]')
					        select('東京都', from: 'user[location]')
					        select('中１', from: 'user[degree]')
					        find("input[name='commit']").click
					    end
					    scenario "レンダーしているか" do
					        expect(page).to have_current_path users_update_path
					    end
					end
			end
			feature "chatroom画面に行けるか" do
				let(:current_user) {@user2}
				before do
					# 友達申請
					@user2 = FactoryBot.create(:children)
					@user1.request(@user2)
					logout(:user)
					# 友達承認
					login_as(@user2, :scope => :user, :run_callbacks => false)
					@user2.approve_friend(@user1)
					# チャットルームとメンバーの作成
					room = Chatroom.create(title: "#{@user1.name}さんと#{@user2.name}さんのチャットルーム")
					# チャット
					Chatmember.create(chatroom_id: room.id, user_id: @user2.id)
					Chatmember.create(chatroom_id: room.id, user_id: @user1.id)
      				visit users_show_path(@user2)
      				puts current_path
    			end
    			scenario "chatroom画面へのリンクはあるか？" do
    				expect(page).to have_link "", href: users_chatroom_path(id: @user1.chatroom_number(@user1, @user2), other_user_id: @user1.id)
    			end
    			scenario "chatroom画面へ遷移できるか？" do
    				click_on 'チャットを開始する', match: :first
    				expect(page).to have_current_path users_chatroom_path(id: @user1.chatroom_number(@user1, @user2), other_user_id: @user1.id)
    			end
			end
	end
end