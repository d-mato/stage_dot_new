require 'rails_helper'

describe User do
  let(:user) { FactoryGirl.create :user }

  describe 'Validations' do
    it 'emailはユニークであること' do
      test_user = User.new(email: user.email)
      expect(test_user).not_to be_valid
      expect(test_user.errors[:email]).to be_present
    end
  end

  describe 'Associations' do
    describe :friendships do
      let!(:friend) { FactoryGirl.create :user }
      let!(:friendship) { user.friendships.create!(friend_id: friend.id) }
      it { expect(user.friendships).to include friendship }
    end

    describe :friends do
      let!(:friend) { FactoryGirl.create :user }
      let!(:friendship) { user.friendships.create!(friend_id: friend.id) }

      it 'accepted_atが空ならfriendsでない' do
        friendship.update!(accepted_at: nil)
        expect(user.friends).not_to include friend
      end

      it 'friendshipのaccepted_atを更新したらfriendsになる' do
        friendship.update!(accepted_at: Time.zone.now)
        expect(user.friends).to include friend
      end
    end
  end
end
