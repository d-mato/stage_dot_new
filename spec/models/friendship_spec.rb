require 'rails_helper'

describe Friendship do
  let(:alice) { FactoryGirl.create :user }
  let(:bob) { FactoryGirl.create :user }

  describe 'Validations' do
    let(:friendship) { Friendship.new }
    it 'user_idとfriend_idが共に空でないならvalid' do
      expect(friendship).not_to be_valid

      friendship.user = alice
      expect(friendship).not_to be_valid

      friendship.friend = bob
      expect(friendship).to be_valid
    end
  end

  describe 'Scopes' do
    describe :accepted do
      subject { Friendship.accepted }

      it 'accepted_atが空のものは含まれない' do
        friendship = FactoryGirl.create :friendship, accepted_at: nil
        is_expected.not_to include friendship
      end

      it 'accepted_atが空でないものは含まれる' do
        friendship = FactoryGirl.create :friendship, accepted_at: Time.zone.now
        is_expected.to include friendship
      end
    end

    describe :pended do
      subject { Friendship.pended }

      it 'accepted_atが空のものは含まれる' do
        friendship = FactoryGirl.create :friendship, accepted_at: nil
        is_expected.to include friendship
      end

      it 'accepted_atが空でないものは含まれない' do
        friendship = FactoryGirl.create :friendship, accepted_at: Time.zone.now
        is_expected.not_to include friendship
      end
    end

  end
end
