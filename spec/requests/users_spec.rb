require 'rails_helper'

describe 'Users' do
  describe 'GET /users' do
    let(:user) { FactoryGirl.create :user }

    it 'ログインしていなければリダイレクト' do
      get '/users'
      expect(response).to have_http_status(302)
    end

    context 'ログインした' do
      before { sign_in user }

      it 'returns 200' do
        get users_path
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET /users/:id' do
    let(:user) { FactoryGirl.create :user }
    let(:alice) { FactoryGirl.create :user }

    it 'ログインしていなければリダイレクト' do
      get "/users/#{alice.id}"
      expect(response).to have_http_status(302)
    end

    context 'ログインした' do
      before { sign_in user }

      it '自分のページは見られる (200)' do
        get "/users/#{user.id}"
        expect(response).to have_http_status(200)
      end

      it '友達でないUserのページは見られない (302)' do
        get "/users/#{alice.id}"
        expect(response).to have_http_status(302)
      end

      it '友達になったら見られる (200)' do
        user.friendships.create(friend_id: alice.id)
        alice.received_friendships.last.accept!

        get "/users/#{alice.id}"
        expect(response).to have_http_status(200)
      end
    end
  end
end
