require 'rails_helper'

RSpec.feature 'Sessions' do
  describe 'OmniAuthによるログイン' do
    before { sign_in_via_github }

    specify 'Githubでログイン(初回)' do
      expect(page).to have_content 'Logout'
    end

    specify 'ログアウト' do
      click_link 'Logout'
      expect(page).to have_content '転職活動をもっとスマートに'
    end

    specify 'ログアウトしてからの再ログイン' do
      click_link 'Logout'
      sign_in_via_github
      expect(page).to have_content 'Logout'
    end

    def sign_in_via_github
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
        provider: 'github',
        uid: '1234',
        info: { nickname: Faker::Name.name, email: Faker::Internet.email },
        extra: {}
      )
      visit '/'
      click_link 'Githubでログイン'
    end
  end

  describe 'No session' do
    specify 'トップページにリダイレクトされること' do
      visit '/companies'
      expect(page.current_path).to eq '/'
    end
  end
end
