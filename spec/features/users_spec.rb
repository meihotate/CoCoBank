require 'rails_helper'

RSpec.feature "Userに関するテスト", type: :feature do
	before do
		@user1 = FactoryBot.create(:children)
	end
	feature "ログインした状態で" do
		before do
      		login_as(@user1, :scope => :user)
    	end
			feature "自分のプロフィールの更新" do
				before do
			    	visit users_editing_path
			    	puts current_path
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
			    	puts current_path
					expect(page).to have_current_path users_show_path(@user1)
				end
			end
			feature "chatroom画面に行けるか" do
				before do
      				visit users_editing_path
      				
    			end
			end
	end
end