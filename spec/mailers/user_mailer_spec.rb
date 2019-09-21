require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
	describe 'welcome_email' do
		before do
			@user = FactoryBot.create(:user)
		end
		let(:mail) { UserMailer.with(user: @user).welcome_email }

		it "sends an email" do
	      expect do
	        mail.deliver
	      end.to change { ActionMailer::Base.deliveries.size }.by(1)
	    end

	    it "renders the subject" do
	      expect(mail.subject).to eq 'CoCoBank_カウンセラー登録が完了しました'
	    end

	    it "renders the receiver email" do
	      expect(mail.to).to eq [@user.email]
	    end

	    it "renders the sender email" do
	      expect(mail.from).to eq ['notifications@example.com']
	    end
		
 #    let(:user) { User.new(name: 'Lucas', email: 'lucas@email.com', sex: 0, location: 0, degree: 0, approved: 2) }
 #    let(:mail) { user.welcome_email(user).deliver_later }

	#     it 'renders the subject' do
	#       expect(mail.subject).to eq('CoCoBank_カウンセラー登録が完了しました')
	#     end

	#     it 'renders the receiver email' do
	#       expect(mail.to).to eq([user.email])
	#     end

	#     it 'renders the sender email' do
	#       expect(mail.from).to eq(['notifications@example.com'])
	#     end

	#     it 'assigns @name' do
	#       expect(mail.body.encoded).to match(user.name)
	#     end
	end

end