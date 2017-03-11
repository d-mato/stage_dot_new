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

  describe 'Methods' do
    describe :friend? do
      let(:alice) { FactoryGirl.create :user }
      let(:bob) { FactoryGirl.create :user }
      subject { alice.friend? bob }

      it { is_expected.to be false }
      it do
        alice.friendships.create(friend_id: bob.id)
        bob.received_friendships.last.accept!
        is_expected.to be true
      end
    end
  end

  describe 'ClassMethods' do
    describe '.create_with_social_profile' do
      let(:social_profile) { FactoryGirl.create :social_profile }

      it 'SocialProfileインスタンスからUserを作成できること' do
        user = User.create_with_social_profile!(social_profile)
        expect(user.persisted?).to be true
        expect(user.email).to eq social_profile.email
      end

      it 'SocialProfileインスタンスがUserと紐付いていること' do
        user = User.create_with_social_profile!(social_profile)
        expect(social_profile.reload.user).to eq user
      end

      describe 'User#name定義におけるSocialProfileの#nicknameと#nameの優先順位' do
        let(:user) { User.create_with_social_profile!(social_profile) }

        it 'SocialProfile#nicknameが優先されてUser#nameになる' do
          expect(user.name).to eq social_profile.nickname
        end

        it 'SocialProfile#nicknameが空ならSocialProfile#nameがUser#nameになる' do
          social_profile.nickname = nil
          expect(user.name).to eq social_profile.name
        end
      end

      context '与えられたSocialProfileのemailが既にUserに登録されている場合' do
        before { FactoryGirl.create :user, email: social_profile.email }

        it '新たにUserを作成できない' do
          expect { User.create_with_social_profile!(social_profile) }.to change { User.count }.by(0)
        end

        it 'nilを返す' do
          expect(User.create_with_social_profile!(social_profile)).to be_nil
        end
      end
    end
  end
end
