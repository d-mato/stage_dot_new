require 'rails_helper'

RSpec.feature 'Sessions' do
  describe 'OmniAuthによるログイン' do
    let(:uid) { '1234' }
    let(:provider) { 'github' }
    let(:nickname) { 'john' }
    let(:email) { 'john@example.com' }
    let(:profile) { SocialProfile.find_by(provider: provider, uid: uid) }
    before { sign_in_via_github }

    specify 'Githubでログイン' do
      expect(page).to have_content 'Logout'
    end

    specify 'Userが登録されていること' do
      expect(profile.user.email).to eq email
      expect(profile.user.name).to eq nickname
    end

    specify 'ログアウト' do
      click_link 'Logout'
      expect(page).to have_content '転職活動をもっとスマートに'
    end

    def sign_in_via_github
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
        provider: provider,
        uid: uid,
        info: { nickname: nickname, email: email },
        extra: {}
      )
      visit '/'
      click_link 'Githubでログイン'
    end
  end
end
