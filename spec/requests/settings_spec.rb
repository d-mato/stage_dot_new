require 'rails_helper'

describe 'Settings' do
  let(:user) { FactoryGirl.create :user, name: Faker::Name.name }
  before { sign_in user }

  describe 'GET /settings/account' do
    before { get '/settings/account' }
    it { expect(response).to have_http_status(200) }
  end

  describe 'PUT /settings/account' do
    let(:new_name) { Faker::Name.name }
    let(:new_email) { 'new-email@example.com' }
    before { put '/settings/account', params: { name: new_name, email: new_email } }

    it('user.name was updated') { expect(user.reload.name).to eq new_name }
    it('user.email was updated') { expect(user.reload.email).to eq new_email }
    it { expect(response).to redirect_to('/settings/account') }
  end
end
