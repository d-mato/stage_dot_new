require 'rails_helper'

describe 'Settings' do
  let!(:user) { FactoryGirl.create :user, name: Faker::Name.name }
  before { sign_in user }

  describe 'GET /settings/account' do
    before { get '/settings/account' }
    it { expect(response).to have_http_status(200) }
  end

  describe 'PUT /settings/account' do
    context 'invalid values' do
      let!(:defaults) { { name: user.name, email: user.email } }

      it '名前が空なら更新しない' do
        put '/settings/account', params: { name: '', email: Faker::Internet.email }
        expect(user.reload.name).to eq defaults[:name]
      end

      it 'Emailが空なら更新しない' do
        put '/settings/account', params: { name: Faker::Name.name, email: '' }
        expect(user.reload.email).to eq defaults[:email]
      end

      it '既に使用されているEmailを入力したら更新せずにエラーメッセージを表示すること' do
        someone = FactoryGirl.create :user, email: 'someone@example.com'
        put '/settings/account', params: { email: someone.email }
        expect(user.reload.email).to eq defaults[:email]
        expect(response.body).to include 'メールアドレスはすでに存在します'
      end
    end

    context 'valid values' do
      let(:new_name) { Faker::Name.name }
      let(:new_email) { 'new-email@example.com' }
      before { put '/settings/account', params: { name: new_name, email: new_email } }

      it('user.name was updated') { expect(user.reload.name).to eq new_name }
      it('user.email was updated') { expect(user.reload.email).to eq new_email }
      it { expect(response).to redirect_to('/settings/account') }
    end
  end
end
